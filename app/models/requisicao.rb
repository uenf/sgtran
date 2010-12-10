require "brazilian_date"
require 'brazilian-rails'


class Requisicao < ActiveRecord::Base

  belongs_to :viagem
  belongs_to :categoria_de_veiculo
  belongs_to :objetivo_de_reserva
  belongs_to :local_origem, :class_name => 'Cidade'
  belongs_to :local_destino, :class_name => 'Cidade'
  belongs_to :solicitante

  ESPERA                   = "Espera"
  ACEITA                   = "Aceita"
  CANCELADO_PELO_PROFESSOR = "Cancelado pelo professor"
  CANCELADO_PELO_SISTEMA   = "Cancelado pelo sistema"
  REJEITADA                = "Rejeitada"
  FINALIZADA               = "Finalizada"

  use_in_brazilian_format :data_de_reserva

  before_create :gerar_chave_de_seguranca

  validate :validar_categoria_de_veiculo, :validar_objetivo, :validar_outros, :validar_motivo_professor, :validar_motivo_id, :validar_data

  validates_presence_of :nome_telefone_passageiros,
                        :roteiro_da_agenda,
                        :data_de_reserva,
                        :celular

  validates_presence_of :solicitante_id, :message => 'não existe'

  validates_acceptance_of :termo

  def validar_data
    unless self.data_de_reserva.nil?
      @configuracao = Configuracao.all.first
      if not (@configuracao.nil? or @configuracao.data_inicial_proibicao.nil? or @configuracao.data_final_proibicao.nil?) and
        self.data_de_reserva.between?(@configuracao.data_inicial_proibicao, @configuracao.data_final_proibicao)
        errors.add(:base, "Excepcionalmente entre as datas #{@configuracao.data_inicial_proibicao.to_s_br} \
          e #{@configuracao.data_final_proibicao.to_s_br} não aceitaremos requisição.")
      end

      if not self.categoria_de_veiculo.blank? and
        not self.categoria_de_veiculo.numero_minimo_dias.zero? and
        self.data_de_reserva < (Date.today + self.categoria_de_veiculo.numero_minimo_dias.days)
        errors.add(:data_de_reserva, "deve ser no mínimo #{self.categoria_de_veiculo.numero_minimo_dias} dias posterior à data atual")
      end

      if @configuracao.requisicao_somente_este_ano?
        if self.data_de_reserva.year != Date.today.year
          errors.add(:data_de_reserva, "deve estar no ano corrente")
        end
      end

      if (not self.categoria_de_veiculo_id.blank?) and
          not self.categoria_de_veiculo.numero_maximo_dias.zero? and
          self.data_de_reserva > (Date.today + self.categoria_de_veiculo.numero_maximo_dias.days)
          errors.add(:data_de_reserva, "deve ser no máximo #{self.categoria_de_veiculo.numero_maximo_dias} dias posterior à data atual, para a categoria de veículo selecionada")
      end
    end
  end

  def validar_motivo_professor
    if self.motivo_professor.blank? and estado == CANCELADO_PELO_PROFESSOR
      errors.add(:motivo, "nao pode ser vazio")
    end
  end

  def validar_motivo_id
    if self.motivo_id.nil? and self.estado == REJEITADA || self.estado == CANCELADO_PELO_SISTEMA
      errors.add(:motivo, "não pode ser vazio")
    end
  end

  def validar_outros
    if not self.objetivo_de_reserva_id.blank?
      objetivo_de_reserva = ObjetivoDeReserva.find(self.objetivo_de_reserva_id)
      if objetivo_de_reserva.texto == "Outros" and (self.outros.empty?)
        errors.add(:outros, 'não pode ser vazio')
      end
    end
  end

  def validar_objetivo
    if self.objetivo_de_reserva_id.blank?
      errors.add(:objetivo_de_reserva, 'não selecionado')
    end
  end

  def validar_categoria_de_veiculo
    if self.categoria_de_veiculo_id.blank?
      errors.add(:categoria_de_veiculo, 'não selecionada')
    end
  end

  def analisar_requisicao solicitante
    solicitante.matricula = Solicitante.normalizar_matricula(solicitante.matricula)

    if Solicitante.existe_e_esta_ativo? solicitante
      self.solicitante_id = Solicitante.find_by_matricula(solicitante.matricula).id
      return self.save
    else
      self.valid?
      self.errors.add(:base, "Solicitante não existe.")
      return false
    end
  end

  private
  def gerar_chave_de_seguranca
    self.chave_de_seguranca = ActiveSupport::SecureRandom.hex(20)
  end

  public
  def cancelar_pelo_professor(motivo)
    if self.pode_ser_cancelada_pelo_professor?
      if not motivo.empty?
        viagem_id = self.viagem_id
        self.estado = CANCELADO_PELO_PROFESSOR
        self.motivo_professor = motivo
        self.motivo_id = nil
        self.viagem_id = nil
        self.save_with_validation false
        Viagem.verificar_viagem viagem_id if viagem_id
        return true
      else
        self.errors.add(:motivo, "não pode ser vazio")
        return false
      end
    else
      self.errors.add_to_base("Requisição não pode ser cancelada.")
      return false
    end
  end

  public
  def aceitar viagem
    self.estado = ACEITA
    viagem_antiga = self.viagem_id
    self.viagem_id = viagem.id
    self.motivo_id = nil
    self.motivo_observacao = nil
    if self.save_with_validation false
      if viagem_antiga and Requisicao.find_all_by_viagem_id(viagem_antiga).empty?
        Viagem.cancelar_viagem_que_nao_atende_nenhuma_requisicao viagem_antiga
      end
    end
  end

  def aceitar_com_viagem_existente(viagem_id)
    if self.pode_ser_aceita?
      viagem = Viagem.find(viagem_id)
      viagem_old = self.viagem_id

      self.estado    = ACEITA
      self.viagem_id = viagem.id
      self.motivo_id = nil

      if self.save_with_validation false
        if viagem_old
          if Viagem.pode_ser_cancelada? viagem_old
            Viagem.cancelar_viagem_que_nao_atende_nenhuma_requisicao viagem_old
          end
        end
        viagem
      else
        nil
      end
    end
  end

  def self.filtrar opcao
    case opcao.to_s
      when "Em Espera" then
        return Requisicao.find_all_by_estado(Requisicao::ESPERA, :order => "id ASC")
      when "Rejeitada" then
        return Requisicao.find_all_by_estado(Requisicao::REJEITADA, :order => "id ASC")
      when "Cancelada pelo Professor" then
        return Requisicao.find_all_by_estado(Requisicao::CANCELADO_PELO_PROFESSOR, :order => "id ASC")
      when "Cancelada pelo Sistema" then
        return Requisicao.find_all_by_estado(Requisicao::CANCELADO_PELO_SISTEMA, :order => "id ASC")
      when "Aceita" then
        return Requisicao.find_all_by_estado(Requisicao::ACEITA, :order => "id ASC")
      when "Todos" then
        return Requisicao.all(:order => "id ASC")
      else
        return Requisicao.all(:conditions => "estado = '" + Requisicao::ESPERA + "'", :order => "id ASC")
    end
  end

  def rejeitar motivo_id
    if self.esta_em_espera?
      self.motivo_id = motivo_id.to_i
      self.estado    = Requisicao::REJEITADA
      if self.save_with_validation false
        true
      else
        false
      end
    end
  end

  def esta_em_espera?
    self.estado == Requisicao::ESPERA
  end

  def esta_aceita?
    self.estado == Requisicao::ACEITA
  end

  def esta_rejeitada?
    self.estado == Requisicao::REJEITADA
  end

  def pode_ser_aceita?
    self.esta_em_espera? or self.esta_rejeitada? or self.esta_aceita?
  end

  def pode_ser_cancelada_pelo_professor?
    [Requisicao::ESPERA, Requisicao::ACEITA].include? self.estado
  end

  def pode_ser_finalizada?
    [Requisicao::ACEITA].include? self.estado
  end

  def cancelar_requisicao motivo_id, corpo_do_email, destinatarios
    if self.esta_aceita?
      viagem = Viagem.find(self.viagem_id)
      self.estado = Requisicao::CANCELADO_PELO_SISTEMA
      self.motivo_id = motivo_id.to_i if motivo_id
      self.motivo_observacao = observacao
      self.viagem_id = nil
      viagem.destroy if viagem.requisicoes.length == 1

      if self.motivo_id
        self.save_with_validation false
        return true
      else
        self.save
        return false
      end
    end
    return false
  end

  def pode_alterar_viagem?
    self.estado == Requisicao::ACEITA
  end

  def alterar_viagem viagem_id
    viagem = Viagem.find(viagem_id)
    if self.pode_alterar_viagem? and viagem.estado == Viagem::AGUARDANDO
      self.viagem_id = viagem.id
      self.save_with_validation false
    else
      false
    end
  end

  def self.buscar_por_nome_de_solicitante nome
    nome, requisicoes = "%" + nome + "%", []
    solicitantes = Solicitante.find(:all, :conditions => ["nome LIKE ?", nome])
    solicitantes.each do |solicitante|
      req = Requisicao.find_all_by_solicitante_id(solicitante.id) if solicitante.id
      req.each do |r|
        requisicoes << r
      end
    end
    requisicoes
  end

  def self.buscar_por_data(inicio, fim)
    if Date.valid?(inicio) and Date.valid?(fim)
      inicio = inicio.gsub("/", "-").to_s
      inicio = Time.parse(inicio).strftime("%Y-%m-%d")
      fim = fim.gsub("/", "-").to_s
      fim = Time.parse(fim).strftime("%Y-%m-%d")
      return Requisicao.find(:all, :conditions => ["data_de_reserva >= :inicio AND data_de_reserva <= :fim", {:inicio => inicio, :fim => fim}])
    else
      return []
    end
  end

  def self.buscar_por_protocolo protocolo
    Requisicao.find_all_by_id(protocolo)
  end

  def self.atualizar_origem_destino cidades_origem, cidades_destino

    cidades_origem.each_pair do |requisicao_id, cidade_id|
      requisicao = Requisicao.find(requisicao_id)
      requisicao.update_attribute(:local_origem_id, cidade_id)
    end

    cidades_destino.each_pair do |requisicao_id, cidade_id|
      requisicao = Requisicao.find(requisicao_id)
      requisicao.update_attribute(:local_destino_id, cidade_id)
    end

  end

end

