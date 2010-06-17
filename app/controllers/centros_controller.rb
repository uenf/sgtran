class CentrosController < ApplicationController
  access_control do
    allow :admin
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @centros = Centro.all
    @sub_layout = "base"
  end

  def show
    @centro = Centro.find(params[:id])
    @sub_layout = "base"
  end

  def new
    @centro = Centro.new
    @sub_layout = "base"
  end

  def edit
    @centro = Centro.find(params[:id])
    @sub_layout = "base"
  end

  def create
    @centro = Centro.new(params[:centro])

    if @centro.save
      flash[:sucesso] = 'Centro criado com sucesso!'
      redirect_to(@centro)
    else
      render :action => "new"
    end
  end

  def update
    @centro = Centro.find(params[:id])

    if @centro.update_attributes(params[:centro])
      flash[:sucesso] = 'Centro modificado com sucesso!'
      redirect_to(@centro)
    else
      render :action => "edit"
    end
  end

  def destroy
    @centro = Centro.find(params[:id])
    @centro.destroy
    @sub_layout = "base"
    redirect_to(centros_url)
  end
end

