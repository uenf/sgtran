class EstadosController < ApplicationController

  access_control do
    allow :admin
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @estados = Estado.all
    @sub_layout = "base"
  end

  def show
    @estado = Estado.find(params[:id])
    @sub_layout = "base"
  end

  def new
    @estado = Estado.new
    @sub_layout = "base"
  end

  def edit
    @estado = Estado.find(params[:id])
    @sub_layout = "base"
  end

  def create
    @estado = Estado.new(params[:estado])

    if @estado.save
      flash[:sucesso] = 'Estado criado com sucesso!'
      redirect_to(@estado)
    else
      render :action => "new"
    end
  end

  def update
    @estado = Estado.find(params[:id])

    if @estado.update_attributes(params[:estado])
      flash[:sucesso] = 'Estado modificado com sucesso!'
      redirect_to(@estado)
    else
      render :action => "edit"
    end
  end

  def destroy
    @estado = Estado.find(params[:id])
    @estado.destroy
    redirect_to(estados_url)
  end

end

