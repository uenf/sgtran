class RelatoriosController < ApplicationController
  access_control do
    allow :admin
  end

  layout "sistema"

  def index
  end

  def km_percorridos
    render 'km_percorridos'
  end

  def show
  end

end

