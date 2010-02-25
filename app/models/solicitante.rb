class Solicitante < ActiveRecord::Base

  has_one :predio

  validates_presence_of :nome,
                        :email,
                        :matricula,
                        :cargo_ou_funcao

  validates_format_of :email,
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validate :validar_andar, :validar_predio


  def self.verificarExistencia dados
    find_by_matricula_and_email_and_cargo_ou_funcao(dados[:matricula], dados[:email], dados[:cargo])
  end

  def validar_predio
    if self.predio_id.blank?
      errors.add(:predio, 'não selecionado')
    end
  end

  def validar_andar
    if self.andar == "Selecione um Andar"
      errors.add(:andar, "não selecionado.")
    end
  end

  def self.andar
    ["Selecione um Andar",
    "Térreo",
    "1º andar",
    "2º andar"]
  end

  def self.verificar_solicitante dados
    solicitante = Solicitante.find_by_matricula_and_email(dados[:matricula], dados[:email])
    if solicitante.blank?
      return false
    else
      return true
    end
  end

end

