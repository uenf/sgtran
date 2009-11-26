class Combustivel < ActiveRecord::Base
  has_and_belongs_to_many :veiculos

  validates_presence_of :nome
end

