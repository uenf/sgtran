class Solicitante < ActiveRecord::Base



  validates_presence_of :matricula,
                        :email,
                        :cargo,
                        :nome

    validates_format_of :email,
                        :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i


  def self.verificarExistencia dados
    find_by_matricula_and_email_and_cargo(dados[:matricula], dados[:email], dados[:cargo])
  end

end

