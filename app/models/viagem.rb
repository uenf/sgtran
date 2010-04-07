require "brazilian_date"

class Viagem < ActiveRecord::Base

  use_in_brazilian_format :data_partida, :data_chegada

  has_many   :requisicoes
  belongs_to :motorista
  belongs_to :veiculo

  AGUARDANDO = "Aguardando"
  ATENDIDA   = "Atendida"
  CANCELADA  = "Cancelada"

  validate :validar_data

  def validar_data
    if self.data_partida && self.data_chegada
      if self.data_partida > self.data_chegada
          self.errors.add("Data de chegada anterior à data de partida")
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

end

