require "brazilian_date"

class Viagem < ActiveRecord::Base

  use_in_brazilian_format :data_partida, :data_chegada

  has_many   :requisicoes
  belongs_to :motorista
  belongs_to :veiculo

  AGUARDANDO = "Aguardando"
  ATENDIDA   = "Atendida"
  CANCELADA  = "Cancelada"

  def requisicoes_atendidas
    atendidas = []
    Requisicao.all.each do |requisicao|
      (atendidas << requisicao.id) if (requisicao.viagem_id == self.id)
    end
    atendidas
  end

end

