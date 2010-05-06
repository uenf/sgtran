require "brazilian_date"

class Viagem < ActiveRecord::Base

  use_in_brazilian_format :data_partida, :data_chegada

  has_many   :requisicoes
  belongs_to :motorista
  belongs_to :veiculo

  AGUARDANDO = "Aguardando"
  ATENDIDA   = "Atendida"
  CANCELADA  = "Cancelada"

  validates_presence_of :motorista_id
  validate :validar_data

  def validar_data
    if self.data_partida and self.data_chegada
      if self.data_partida > self.data_chegada
          self.errors.add("Data de chegada anterior à data de partida. Isso")
      end
      if ((self.data_partida < Date.today) or (self.data_chegada < Date.today))
        self.errors.add("As datas não podem ser anteriores à data atual. Isso")
      end
    end
  end

  def self.filtrar opcao
    case opcao.to_s
      when "Aguardando" then
        return Viagem.find_all_by_estado(Viagem::AGUARDANDO, :order => "id ASC")
      when "Cancelada" then
        return Viagem.find_all_by_estado(Viagem::CANCELADA, :order => "id ASC")
      when "Atendida" then
        return Viagem.find_all_by_estado(Viagem::ATENDIDA, :order => "id ASC")
      when "Todos" then
        return Viagem.all(:order => "id ASC")
      else
        return Viagem.all(:conditions => "estado = '" + Viagem::AGUARDANDO + "'", :order => "id ASC")
    end
  end

  def requisicoes_atendidas
    atendidas = []
    Requisicao.find_all_by_viagem_id(self.id).each do |requisicao|
      (atendidas << requisicao.id)
    end
    atendidas
  end

  def nomes_solicitantes
    solicitantes = []
    self.requisicoes_atendidas.each do |requisicao_id|
      solicitante_id = Requisicao.find(requisicao_id).solicitante_id
      solicitante = Solicitante.find(solicitante_id)
      solicitantes << solicitante.nome if not solicitantes.include? solicitante.nome
    end
    solicitantes
  end

  def esta_aguardando?
    if self.estado == Viagem::AGUARDANDO
      return true
    end
    return false
  end

  def cancelar_viagem motivo_id
    if self.esta_aguardando?
      requisicoes = Requisicao.find_all_by_viagem_id(self.id)
      requisicoes.each do |r|
        r.estado = Requisicao::ESPERA
        r.viagem_id = nil
        r.save!
      end
      self.estado = Viagem::CANCELADA
      self.motivo_id = motivo_id.to_i
      self.save!
    end
  end

  def pode_ser_fechada?
    if self.estado == Viagem::AGUARDANDO
      true
    else
      false
    end
  end

  def fechar_viagem
    requisicoes_atendidas = Requisicao.find_all_by_viagem_id(self.id)
    if self.pode_ser_fechada?
      self.estado = Viagem::ATENDIDA
      if self.save_with_validation false
        requisicoes_atendidas.each do |r|
          r.estado = Requisicao::FINALIZADA
          r.save_with_validation false
        end
        return true
      else
        return false
      end
    else
      return false
    end
  end

end

