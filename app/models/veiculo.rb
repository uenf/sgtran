class Veiculo < ActiveRecord::Base
  has_one :categoria_de_veiculo
  has_and_belongs_to_many :combustiveis
end

