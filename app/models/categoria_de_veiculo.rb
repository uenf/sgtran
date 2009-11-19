class CategoriaDeVeiculo < ActiveRecord::Base
  belongs_to :veiculo
  belongs_to :requisicao
end

