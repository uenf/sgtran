class CidadesController < ApplicationController

  def index
    @cidades = Cidade.all
  end

  def show
    @cidade = Cidade.find(params[:id])
  end

  def new
    @cidade = Cidade.new
  end

  def edit
    @cidade = Cidade.find(params[:id])
  end

  def create
    @cidade = Cidade.new(params[:cidade])

    if @cidade.save
      flash[:notice] = 'Cidade criada com sucesso!'
      redirect_to(@cidade)
    else
      render :action => "new"
    end

  end

  def update
    @cidade = Cidade.find(params[:id])

    if @cidade.update_attributes(params[:cidade])
      flash[:notice] = 'Cidade modificada com sucesso!'
      redirect_to(@cidade)
    else
      render :action => "edit"
    end

  end

  def destroy
    @cidade = Cidade.find(params[:id])
    @cidade.destroy
    redirect_to(cidades_url)
  end

end

