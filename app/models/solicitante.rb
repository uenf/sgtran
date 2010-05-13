class Solicitante < ActiveRecord::Base
  
  ATIVO = "Ativo"
  INATIVO = "Inativo"

  has_one :centro

  validates_presence_of :nome,
                        :email,
                        :matricula,
                        :cargo

  validates_format_of :email,
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def self.verificar_solicitante dados
    return false if Solicitante.find_by_matricula_and_email_and_estado(dados[:matricula], dados[:email], Solicitante::ATIVO).nil?
    true
  end

  def self.normalizar_matricula matricula
    tamanho = 5 - matricula.length
    if tamanho > 0
      tamanho.times do
        matricula = "0" + matricula
      end
    end
    matricula
  end
end

