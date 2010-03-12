class ObjetivoDeReserva < ActiveRecord::Base

  belongs_to :requisicao

  validates_presence_of :texto

end

