require "brazilian_date"

class Viagem < ActiveRecord::Base

  use_in_brazilian_format :data_partida, :data_chegada

  has_many   :requisicoes
  belongs_to :motorista

  AGUARDANDO = "Aguardando"
  ATENDIDA   = "Atendida"
  CANCELADA  = "Cancelada"
  
  
  def self.filtrar opcao
    case opcao.to_s
      when "Aguardando" then
        return Viagem.find_by_estado(Viagem::AGUARDANDO, :order => "id ASC")
      when "Cancelada" then
        return Viagem.find_by_estado(Viagem::CANCELADA, :order => "id ASC")
      when "Atendida" then
        return Viagem.find_by_estado(Viagem::ATENDIDA, :order => "id ASC")
      when "Todos" then
        return Viagem.all(:order => "id ASC")
      else
        return Viagem.all(:conditions => "estado = '" + Viagem::AGUARDANDO + "'", :order => "id ASC")
    end    
  end

end

