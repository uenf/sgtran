class SistemaController < ApplicationController
  access_control do
    allow :admin
  end

  layout "sistema"

  def base_de_dados
  end

  def relatorios
  end

end

