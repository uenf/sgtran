class RelatoriosController < ApplicationController
  access_control do
    allow :admin
  end

  layout "sistema"

  def index
  end

  def km_percorridos
    @relatorio = Relatorio.new
  end

  def show_km_percorridos
    @relatorio = Relatorio.new(params[:relatorio])
    if @relatorio.valid?
      @kms = Bdt.distancia_percorrida_entre(@relatorio.data_inicial,
                                            @relatorio.data_final)
    else
      render :action => :km_percorridos
    end
  end

end

