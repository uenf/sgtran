class Solicitante < ActiveRecord::Base

  validates_presence_of :matricula,
                        :email,
                        :cargo_ou_funcao,
                        :nome

  validates_format_of :email,
                        :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validate :validar_predio, :validar_andar


  def self.verificarExistencia dados
    find_by_matricula_and_email_and_cargo_ou_funcao(dados[:matricula], dados[:email], dados[:cargo])
  end

  def validar_predio
    if self.predio == "Selecione um Prédio"
      errors.add(:predio, "inválido.")
    end
  end

  def validar_andar
    if self.andar == "Selecione um Andar"
      errors.add(:sala, "inválida.")
    end
  end

  def self.predios
    ["Selecione um Prédio",
    "Reitoria - E1",
    "CCT - Prédio",
    "CCT - Anexo",
    "CCT - Oficinas",
    "CBB - Prédio",
    "CBB - Anexo",
    "CCTA - Prédio",
    "CCTA - Anexo",
    "CCTA - Pesagro",
    "CCTA - Escola Agrícola",
    "CCTA - Itaocara",
    "CCH - Prédio",
    "P4",
    "P5",
    "Villa Maria",
    "LENEP - Macaé"]
  end

  def self.andar
    ["Selecione um Andar",
    "Térreo",
    "1º andar",
    "2º andar"]
  end

end

