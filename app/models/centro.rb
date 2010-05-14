class Centro < ActiveRecord::Base
  ATIVO = "Ativo"
  INATIVO = "Inativo"
  belongs_to :solicitante

  validates_presence_of :nome
end

