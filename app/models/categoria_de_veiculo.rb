class CategoriaDeVeiculo < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  has_many :veiculos
  has_many :requisicoes

  validates_presence_of :nome
end

