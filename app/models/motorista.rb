class Motorista < ActiveRecord::Base
  has_many :viagens

  validates_presence_of :matricula,
                        :nome_do_motorista,
                        :telefone_do_motorista



  def self.verificarExistencia dados
    find_by_matricula(dados[:matricula])
  end
end

