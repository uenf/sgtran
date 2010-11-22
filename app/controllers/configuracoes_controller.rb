class ConfiguracoesController < ApplicationController

  access_control do
    allow :admin
  end

  layout 'sistema'

  def edit
    @configuracao = Configuracao.all.first
  end

  def update

    @configuracao = Configuracao.find(params[:id])

    if @configuracao.update_attributes(params[:configuracao])
      flash[:sucesso] = 'Configurações atualizadas com sucesso.'
      redirect_to(edit_configuracao_path(@configuracao))
    else
      render :action => "edit"
    end

  end

end

