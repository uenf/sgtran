require "brazilian_date"

class Configuracao < ActiveRecord::Base

  use_in_brazilian_format :data_inicial_proibicao, :data_final_proibicao

end

