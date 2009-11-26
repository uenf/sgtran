class CategoriaDeVeiculo < ActiveRecord::Base
  belongs_to :veiculo
  belongs_to :requisicao

  validates_presence_of :nome
end

