class Motivo < ActiveRecord::Base
  
  ATIVO = "Ativo"
  INATIVO = "Inativo"
  
  validates_presence_of :descricao
end

