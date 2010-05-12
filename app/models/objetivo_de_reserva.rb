class ObjetivoDeReserva < ActiveRecord::Base
  
  ATIVO = "Ativo"
  INATIVO = "Inativo"

  belongs_to :requisicao

  validates_presence_of :texto

end

