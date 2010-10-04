class Solicitante < ActiveRecord::Base

  ATIVO = "Ativo"
  INATIVO = "Inativo"

  belongs_to :centro

  has_many :requisicoes

  validates_presence_of :nome,
                        :email,
                        :matricula,
                        :cargo

  validates_format_of :email,
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def self.verificar_solicitante dados
    return false if Solicitante.find_by_matricula_and_email_and_status(dados[:matricula], dados[:email], Solicitante::ATIVO).nil?
    true
  end

  def self.normalizar_matricula matricula
    tamanho = 5 - matricula.length
    tamanho.times { matricula = "0" + matricula.to_s } if tamanho > 0
    matricula
  end
end

