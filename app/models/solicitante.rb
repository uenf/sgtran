class Solicitante < ActiveRecord::Base

  validates_presence_of :nome,
                        :email,
                        :matricula,
                        :cargo_ou_funcao

  validates_format_of :email,
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validate :validar_predio, :validar_andar


  def self.verificarExistencia dados
    find_by_matricula_and_email_and_cargo_ou_funcao(dados[:matricula], dados[:email], dados[:cargo])
  end

  def validar_predio
    if self.predio == "Selecione um Prédio"
      errors.add(:predio, "não selecionado.")
    end
  end

  def validar_andar
    if self.andar == "Selecione um Andar"
      errors.add(:andar, "não selecionado.")
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

  def self.verificar_solicitante dados
    solicitante = Solicitante.find_by_matricula_and_email(dados[:matricula], dados[:email])
    if solicitante.blank?
      return false
    else
      return true
    end
  end

end

