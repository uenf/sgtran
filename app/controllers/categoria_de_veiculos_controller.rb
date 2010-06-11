class CategoriaDeVeiculosController < ApplicationController
  access_control do
    allow :admin, :to => [:index, :new, :show, :create, :edit, :destroy, :update]
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @categoria_de_veiculos = CategoriaDeVeiculo.all
    @sub_layout = "base"
  end

  def show
    @categoria_de_veiculo = CategoriaDeVeiculo.find(params[:id])
    @sub_layout = "base"
  end

  def new
    @categoria_de_veiculo = CategoriaDeVeiculo.new
    @sub_layout = "base"
  end

  def edit
    @categoria_de_veiculo = CategoriaDeVeiculo.find(params[:id])
    @sub_layout = "base"
  end

  def create
    @categoria_de_veiculo = CategoriaDeVeiculo.new(params[:categoria_de_veiculo])

    if @categoria_de_veiculo.save
      flash[:sucesso] = 'Categoria de veículo criada com sucesso!'
      redirect_to(@categoria_de_veiculo)
    else
      @sub_layout = "base"
      render :action => "new"
    end
  end

  def update
    @categoria_de_veiculo = CategoriaDeVeiculo.find(params[:id])

    if @categoria_de_veiculo.update_attributes(params[:categoria_de_veiculo])
      flash[:sucesso] = 'Categoria de veículo modificada com sucesso!'
      redirect_to(@categoria_de_veiculo)
    else
      @sub_layout = "base"
      render :action => "edit"
    end
  end

  def destroy
    @categoria_de_veiculo = CategoriaDeVeiculo.find(params[:id])
    @categoria_de_veiculo.destroy
    @sub_layout = "base"
    redirect_to(categoria_de_veiculos_url)
  end
end

