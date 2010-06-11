class CombustiveisController < ApplicationController
  access_control do
    allow :admin, :to => [:index, :new, :show, :create, :edit, :destroy, :update]
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @combustiveis = Combustivel.all
    @sub_layout = "base"
  end

  def show
    @combustivel = Combustivel.find(params[:id])
    @sub_layout = "base"
  end

  def new
    @combustivel = Combustivel.new
    @sub_layout = "base"
  end

  def edit
    @combustivel = Combustivel.find(params[:id])
    @sub_layout = "base"
  end

  def create
    @combustivel = Combustivel.new(params[:combustivel])

    if @combustivel.save
      flash[:sucesso] = 'Combustível criado com sucesso!'
      redirect_to(@combustivel)
    else
      @sub_layout = "base"
      render :action => "new"
    end
  end

  def update
    @combustivel = Combustivel.find(params[:id])

    if @combustivel.update_attributes(params[:combustivel])
      flash[:sucesso] = 'Combustível modificado com sucesso!'
      redirect_to(@combustivel)
    else
      @sub_layout = "base"
      render :action => "edit"
    end
  end

  def destroy
    @combustivel = Combustivel.find(params[:id])
    @combustivel.destroy
    @sub_layout = "base"
    redirect_to(combustiveis_url)
  end
end

