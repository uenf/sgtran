class Solicitante < ActiveRecord::Base

  has_one :centro

  validates_presence_of :nome,
                        :email,
                        :matricula,
                        :cargo

  validates_format_of :email,
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def self.verificarExistencia dados
    find_by_matricula_and_email_and_cargo(dados[:matricula], dados[:email], dados[:cargo])
  end

  def self.verificar_solicitante dados

    solicitante = Solicitante.find_by_matricula_and_email(dados[:matricula], dados[:email])
    if solicitante.blank?
      return false
    else
      return true
    end
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

