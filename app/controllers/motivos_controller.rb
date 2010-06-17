class MotivosController < ApplicationController
  access_control do
    allow :admin
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @motivos = Motivo.all
    @sub_layout = "base"
  end

  def show
    @motivo = Motivo.find(params[:id])
    @sub_layout = "base"
  end

  def new
    @motivo = Motivo.new
    @sub_layout = "base"
  end

  def edit
    @motivo = Motivo.find(params[:id])
    @sub_layout = "base"
  end

  def create
    @motivo = Motivo.new(params[:motivo])

    if @motivo.save
      flash[:sucesso] = 'Motivo criado com sucesso!'
      redirect_to(@motivo)
    else
      render :action => "new"
    end
  end

  def update
    @motivo = Motivo.find(params[:id])

    if @motivo.update_attributes(params[:motivo])
      flash[:sucesso] = 'Motivo modificado com sucesso!'
      redirect_to(@motivo)
    else
      render :action => "edit"
    end
  end

  def destroy
    @motivo = Motivo.find(params[:id])
    @motivo.destroy
    @sub_layout = "base"
    redirect_to(motivos_url)
  end
end

