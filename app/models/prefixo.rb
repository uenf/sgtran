class Prefixo < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  has_many :veiculo

  validates_presence_of :nome

  def self.ativos
    Prefixo.find_all_by_status(ATIVO)
  end

end

