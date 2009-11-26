require "brazilian_date"

class Requisicao < ActiveRecord::Base
  belongs_to :viagem
  has_one :categoria_de_veiculo

  ESPERA                   = "Espera"
  ACEITA                   = "Aceita"
  CANCELADO_PELO_PROFESSOR = "Cancelado pelo professor"
  CANCELADO_PELO_SISTEMA   = "Cancelado pelo sistema"
  REJEITADA                = "Rejeitada"
  ATENDIDA                 = "Atendida"

  use_in_brazilian_format :data_de_reserva

  before_create :gerar_chave_de_seguranca

  validate :validar_predio, :validar_andar, :validar_categoria_de_veiculo, :validar_objetivo, :validar_outros, :validar_motivo, :validar_data

  protected
  def validar_data
    unless self.data_de_reserva == nil
      if self.data_de_reserva < Date.tomorrow.tomorrow
        errors.add(:data_de_reserva, "deve ser no mínimo 2 dias posterior à data atual")
      end
      if self.data_de_reserva.year != Date.today.year
        errors.add(:data_de_reserva, "deve estar no ano corrente")
      end
      if self.categoria_de_veiculo_id != 0 and CategoriaDeVeiculo.find(self.categoria_de_veiculo_id).nome !~ /^(((M|m)icro-)?(Ô|ô)nibus)|(V|v)(an|AN)/
        if self.data_de_reserva > (Date.today + 15.days)
          errors.add(:data_de_reserva, "deve ser no máximo 15 dias posterior à data atual, para a categoria de veículo selecionada")
        end
      end
    end
  end

  protected
  def validar_motivo
    if motivo.blank? && estado == CANCELADO_PELO_PROFESSOR
      errors.add(:motivo, "nao pode ser vazio")
    end
  end

  def validar_outros
    if self.objetivo_da_reserva == 'Outros' and self.outros.empty?
      errors.add(:outros, 'não pode ser vazio')
    end
  end

  protected
  def validar_predio
    if self.predio == "Selecione um Prédio"
      errors.add(:predio, 'não selecionado')
    end
  end

  protected
  def validar_andar
    if self.andar == "Selecione um Andar"
      errors.add(:andar, 'não selecionado')
    end
  end

  protected
  def validar_categoria_de_veiculo
    if self.categoria_de_veiculo_id == 0
      errors.add(:categoria_de_veiculo, 'não selecionada')
    end
  end

  protected
  def validar_objetivo
    if self.objetivo_da_reserva == "Selecione um Objetivo"
      errors.add(:objetivo_da_reserva, 'não selecionado')
    end
  end


  validates_presence_of :cargo_ou_funcao,
                        :telefone_ou_ramal,
                        :laboratorio_ou_setor,
                        :sala,
                        :nome_telefone_passageiros,
                        :roteiro_da_agenda,
                        :data_de_reserva

  validates_presence_of :solicitante_id, :message => 'não existe'

  validates_acceptance_of :termo


  def self.predio
    ["Selecione um Prédio",
    "Reitoria - E1",
    "CCT - Prédio",
    "CCT - Anexo",
    "CCT - Oficinas",
    "CBB - Prédio",
    "CBB - Anexo",
    "CCTA - Prédio",
    "CCTA - Anexo",
    "CCTA - Pesagro",
    "CCTA - Escola Agrícola",
    "CCTA - Itaocara",
    "CCH - Prédio",
    "P4",
    "P5",
    "Villa Maria",
    "LENEP - Macaé"]
  end

  def self.andar
    ["Selecione um Andar",
    "Térreo",
    "1º andar",
    "2º andar"]
  end

  def self.objetivo
    ["Selecione um Objetivo",
    "Aula de Campo",
    "Compras",
    "Malote ou Correspondência",
    "Trabalho de Campo",
    "Visita Técnica",
    "Transporte de Pessoal",
    "Transporte de Equipamento Natural",
    "Participações em Eventos (micro-ônibus",
    "Participações em Reuniões",
    "Serviços Administrativos",
    "Serviços Técnicos",
    "Outros"]
  end


  def self.verificarSolicitante(dados_solicitante, dados_requisicao)
    solicitante = Solicitante.find_by_matricula_and_email(dados_solicitante[:matricula], dados_solicitante[:email])
    dados_requisicao[:categoria_de_veiculo_id] = dados_requisicao[:categoria_de_veiculo_id].to_i
    requisicao = Requisicao.new dados_requisicao
    requisicao.solicitante_id = solicitante.id if solicitante
    requisicao
  end


  private
  def gerar_chave_de_seguranca
    self.chave_de_seguranca = ActiveSupport::SecureRandom.hex(20)
  end

  public
  def cancelar_pelo_professor(motivo)
    self.estado = CANCELADO_PELO_PROFESSOR
    self.motivo = motivo
    self.save
  end

  def self.instanciarRequisicoes dados_requisicao, dados_data, dados_radio, dados_roteiro_volta, id_solicitante

    if dados_radio == "volta"

      @requisicao_ida = Requisicao.new dados_requisicao
      @requisicao_ida.solicitante_id = id_solicitante
      @requisicao_ida.tipo = "Ida"

      dados_requisicao[:data_de_reserva_br] = dados_data
      dados_requisicao[:roteiro_da_agenda] = dados_roteiro_volta

      @requisicao_volta = Requisicao.new dados_requisicao
      @requisicao_volta.solicitante_id = id_solicitante
      @requisicao_volta.tipo = "Volta"
      [@requisicao_ida, @requisicao_volta]

    else
      @requisicao = Requisicao.new(dados_requisicao)
      @requisicao.solicitante_id = id_solicitante
      [@requisicao]
    end

  end

  def registrarVolta requisicao_volta

    if self.save
      if requisicao_volta.save
        self.referencia_id = requisicao_volta.id
        requisicao_volta.referencia_id = self.id
        self.save
        requisicao_volta.save
      else
        requisicao_volta
      end
    else
      self
    end

  end


  public
  def aceitar(motorista, data_partida, data_chegada, horario_partida)
    viagem = Viagem.new

    viagem.data_partida    = data_partida
    viagem.data_chegada    = data_chegada
    viagem.horario_partida = horario_partida
    viagem.motorista       = motorista
    viagem.estado          = Viagem::AGUARDANDO

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

#    Requisicao.update(self.id, :estado => ACEITA, :viagem_id => viagem.id)

    self.save(perform_validation = false)

    return viagem
    # enviar e-mail aqui
  end

  def aceitar_com_viagem_existente(viagem_id)
    viagem = Viagem.find(viagem_id)

    self.estado    = ACEITA
    self.viagem_id = viagem.id

    self.save!

    return viagem
  end

end

