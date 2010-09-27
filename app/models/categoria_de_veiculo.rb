class CategoriaDeVeiculo < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  has_one :veiculo
  belongs_to :requisicao

  validates_presence_of :nome
end

