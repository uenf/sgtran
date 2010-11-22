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

  def self.existe_e_esta_ativo? solicitante
    solicitante = Solicitante.find_by_matricula_and_email(solicitante.matricula, solicitante.email)
    if solicitante
      return true if solicitante.status == Solicitante::ATIVO
    end
    return false
  end

  def self.normalizar_matricula matricula
    tamanho = 5 - matricula.length
    tamanho.times { matricula = "0" + matricula.to_s } if tamanho > 0
    matricula
  end
end

