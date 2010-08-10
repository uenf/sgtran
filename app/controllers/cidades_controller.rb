class CidadesController < ApplicationController

  layout "sistema"

  def index
    @cidades = Cidade.all
    @sub_layout = "base"
  end

  def show
    @cidade = Cidade.find(params[:id])
    @sub_layout = "base"
  end

  def new
    @cidade = Cidade.new
    @sub_layout = "base"
  end

  def edit
    @cidade = Cidade.find(params[:id])
    @sub_layout = "base"
  end

  def create
    @cidade = Cidade.new(params[:cidade])

    if @cidade.save
      flash[:sucesso] = 'Cidade criada com sucesso!'
      redirect_to(@cidade)
    else
      render :action => "new"
    end

  end

  def update
    @cidade = Cidade.find(params[:id])

    if @cidade.update_attributes(params[:cidade])
      flash[:sucesso] = 'Cidade modificada com sucesso!'
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

