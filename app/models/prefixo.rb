class Prefixo < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  belongs_to :veiculo

  validates_presence_of :nome

  def self.ativos
    Prefixo.find_all_by_status(ATIVO)
  end

end

