class PrefixosController < ApplicationController

  access_control do
    allow :admin
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @prefixos = Prefixo.all
    @sub_layout = "base"
  end

  def show
    @prefixo = Prefixo.find(params[:id])
    @sub_layout = "base"
  end

  def new
    @prefixo = Prefixo.new
    @sub_layout = "base"
  end

  def edit
    @prefixo = Prefixo.find(params[:id])
    @sub_layout = "base"
  end

  def create
    @prefixo = Prefixo.new(params[:prefixo])

    if @prefixo.save
      flash[:sucesso] = 'Prefixo criado com sucesso!'
      redirect_to(@prefixo)
    else
      render :action => "new"
    end
  end

  def update
    @prefixo = Prefixo.find(params[:id])

    if @prefixo.update_attributes(params[:prefixo])
      flash[:sucesso] = 'Prefixo modificado com sucesso!'
      redirect_to(@prefixo)
    else
      render :action => "edit"
    end
  end

  def destroy
    @prefixo = Prefixo.find(params[:id])
    @prefixo.destroy
    redirect_to(prefixos_url)
  end
end

