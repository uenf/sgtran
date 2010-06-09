class SolicitantesController < ApplicationController
  access_control do
    allow :admin
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @solicitantes = Solicitante.all(:order => "nome ASC")
    @sub_layout = "base"
  end

  def show
    @solicitante = Solicitante.find(params[:id])
    @sub_layout = "base"
  end

  def new
    @solicitante = Solicitante.new
    @sub_layout = "base"
  end

  def edit
    @solicitante = Solicitante.find(params[:id])
    @sub_layout = "base"
  end

  def create
    @solicitante = Solicitante.new(params[:solicitante])

    if @solicitante.save
      flash[:sucesso] = 'Solicitante criado com sucesso!'
      redirect_to(@solicitante)
    else
      @sub_layout = "base"
      render :action => "new"
    end
  end

  def update
    @solicitante = Solicitante.find(params[:id])

    if @solicitante.update_attributes(params[:solicitante])
      flash[:sucesso] = 'Solicitante modificado com sucesso!'
      redirect_to(@solicitante)
    else
      @sub_layout = "base"
      render :action => "edit"
    end
  end

  def destroy
    @solicitante = Solicitante.find(params[:id])
    @solicitante.destroy
    @sub_layout = "base"
    redirect_to(solicitantes_url)
  end
end

