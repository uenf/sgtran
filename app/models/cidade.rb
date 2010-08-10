class Cidade < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  belongs_to :estado

  validates_presence_of :nome, :estado_id

  cattr_reader :per_page
  @@per_page = 30


end

