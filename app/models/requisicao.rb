require "brazilian_date"

class Requisicao < ActiveRecord::Base
  belongs_to :viagem
  has_one :categoria_de_veiculo
  has_one :objetivo_de_reserva

  ESPERA                   = "Espera"
  ACEITA                   = "Aceita"
  CANCELADO_PELO_PROFESSOR = "Cancelado pelo professor"
  CANCELADO_PELO_SISTEMA   = "Cancelado pelo sistema"
  REJEITADA                = "Rejeitada"

  IDA = 0
  VOLTA = 1

  use_in_brazilian_format :data_de_reserva

  before_create :gerar_chave_de_seguranca

  validate :validar_categoria_de_veiculo, :validar_objetivo, :validar_outros, :validar_motivo_professor, :validar_motivo_id, :validar_data

  def validar_data
    unless self.data_de_reserva == nil
      if self.data_de_reserva < Date.tomorrow.tomorrow
        errors.add(:data_de_reserva, "deve ser no mínimo 2 dias posterior à data atual")
      end
      if self.data_de_reserva.year != Date.today.year
        errors.add(:data_de_reserva, "deve estar no ano corrente")
      end
      if (not self.categoria_de_veiculo_id.blank?) and
        (CategoriaDeVeiculo.find(self.categoria_de_veiculo_id).nome !~ /^(((M|m)icro-)?(Ô|ô)nibus)|(V|v)(an|AN)/)
        if self.data_de_reserva > (Date.today + 15.days)
          errors.add(:data_de_reserva, "deve ser no máximo 15 dias posterior à data atual, para a categoria de veículo selecionada")
        end
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

  validates_presence_of :nome_telefone_passageiros,
                        :roteiro_da_agenda,
                        :data_de_reserva

  validates_presence_of :solicitante_id, :message => 'não existe'

  validates_acceptance_of :termo

  def self.analisar_requisicao dados
    dados_solicitante = {:matricula => dados[:matricula], :email => dados[:email] }
    if Solicitante.verificar_solicitante dados_solicitante

      solicitante = Solicitante.find_by_matricula_and_email(dados_solicitante[:matricula], dados_solicitante[:email])
      if dados[:tipo] == "Ida e Volta"
        requisicao_ida = Requisicao.new(dados[:requisicao])

        dados[:requisicao][:data_de_reserva_br] = dados[:data_de_reserva_ida_volta]
        dados[:requisicao][:roteiro_da_agenda] = dados[:roteiro_da_agenda_volta]

        requisicao_volta = Requisicao.new(dados[:requisicao])

        requisicao_ida.solicitante_id = solicitante.id
        requisicao_volta.solicitante_id = solicitante.id

        requisicao_ida.save
        requisicao_volta.save
        return [requisicao_ida, requisicao_volta]
      else
        requisicao = Requisicao.new(dados[:requisicao])
        requisicao.solicitante_id = solicitante.id
        requisicao.save
        return [requisicao]
      end
    else
      requisicao = Requisicao.new(dados[:requisicao])
      requisicao.save
      return [requisicao]
    end
  end

  private
  def gerar_chave_de_seguranca
    self.chave_de_seguranca = ActiveSupport::SecureRandom.hex(20)
  end

  public
  def cancelar_pelo_professor(motivo)
    self.estado = CANCELADO_PELO_PROFESSOR
    self.motivo_professor = motivo
    self.motivo_id = nil
    self.save
  end

  def registrarVolta requisicao_volta

    if self.save
      if requisicao_volta.save
        self.referencia_id = requisicao_volta.id
        requisicao_volta.referencia_id = self.id
        self.save
        requisicao_volta.save
        return self
      else
        return requisicao_volta
      end
      return self
    else
      return self
    end

  end


  public
  def aceitar(motorista, veiculo, data_partida, data_chegada, horario_partida)
    if self.esta_em_espera? or self.esta_rejeitada?
      viagem = Viagem.new

      viagem.data_partida = data_partida
      viagem.data_chegada = data_chegada
      viagem.horario_partida = horario_partida
      viagem.motorista = motorista
      viagem.veiculo = veiculo
      viagem.estado = Viagem::AGUARDANDO

      if !data_partida.nil? && !data_chegada.nil?
        if data_partida > data_chegada
            viagem.errors.add(:data_partida, "posterior a data de chegada");
            viagem.errors.add(:data_chegada, "anterior a data de partida");

            return viagem
        end
      end

      viagem.save!

      self.estado = ACEITA
      self.viagem_id = viagem.id
      self.motivo_id = nil
      self.motivo_observacao = nil

  #    Requisicao.update(self.id, :estado => ACEITA, :viagem_id => viagem.id)

      self.save(perform_validation = false)

      return viagem
      # enviar e-mail aqui
    end
  end

  def aceitar_com_viagem_existente(viagem_id)
    if self.esta_em_espera? or self.esta_rejeitada?
      viagem = Viagem.find(viagem_id)

      self.estado    = ACEITA
      self.viagem_id = viagem.id
      self.motivo_id = nil

      self.save!

      return viagem
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

  def self.requisicao_em_espera? requisicao
    if requisicao.estado == Requisicao::ESPERA
      return true
    else
      return false
    end

  end

  def rejeitar motivo_id, observacao
    if Requisicao.requisicao_em_espera? self
      self.estado = Requisicao::REJEITADA
      self.motivo_id = motivo_id.to_i
      self.motivo_observacao = observacao
      self.save
      #Confirmacao.deliver_email_motivo_de_rejeitar(@requisicao)
    end
  end
  
  def esta_em_espera?
    if self.estado == Requisicao::ESPERA
      return true
    else
      return false
    end
    
  end
  
  def esta_aceita?
    if self.estado == Requisicao::ACEITA
      return true
    else
      return false
    end
    
  end
  
  def esta_rejeitada?
    if self.estado == Requisicao::REJEITADA
      return true
    end
    return false
  end
  
  def cancelar_requisicao motivo_id, observacao
    if self.esta_aceita?
      self.estado = Requisicao::CANCELADO_PELO_SISTEMA
      self.motivo_id = motivo_id.to_i
      self.viagem_id = nil
      self.motivo_observacao = observacao
      if self.save
        return true
      else
        return false
      end
    end
    return false
  end

end

