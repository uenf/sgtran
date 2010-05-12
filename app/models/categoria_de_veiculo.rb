class CategoriaDeVeiculo < ActiveRecord::Base
  
  ATIVO = "Ativo"
  INATIVO = "Inativo"
  
  belongs_to :veiculo
  belongs_to :requisicao

  validates_presence_of :nome
end

