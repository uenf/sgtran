class ObjetivoDeReserva < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  has_many :requisicoes

  validates_presence_of :texto

end

