require "brazilian_date"

class Configuracao < ActiveRecord::Base

  use_in_brazilian_format :data_inicial_proibicao, :data_final_proibicao


  def requisicao_somente_este_ano?
    self.ano_corrente
  end

end

