class ObjetivoDeReserva < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  has_many :requisicoes

  validates_presence_of :texto


  def eh_obrigatorio?
    self.obrigatorio
  end

end

