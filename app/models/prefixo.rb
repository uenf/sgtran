class Prefixo < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  validates_presence_of :nome

end

