class Estado < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  has_many :cidades

  validates_presence_of :nome, :sigla

end

