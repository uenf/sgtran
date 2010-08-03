class EstadosController < ApplicationController

  def index
    @estados = Estado.all
  end

  def show
    @estado = Estado.find(params[:id])
  end

  def new
    @estado = Estado.new
  end

  def edit
    @estado = Estado.find(params[:id])
  end

  def create
    @estado = Estado.new(params[:estado])

    if @estado.save
      flash[:notice] = 'Estado criado com sucesso!'
      redirect_to(@estado)
    else
      render :action => "new"
    end
  end

  def update
    @estado = Estado.find(params[:id])

    if @estado.update_attributes(params[:estado])
      flash[:notice] = 'Estado modificado com sucesso!'
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

