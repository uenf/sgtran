class Centro < ActiveRecord::Base
  ATIVO = "Ativo"
  INATIVO = "Inativo"
  has_many :solicitantes

  validates_presence_of :nome
end

