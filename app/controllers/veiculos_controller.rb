class VeiculosController < ApplicationController
  access_control do
    allow :admin
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @veiculos = Veiculo.all
    @sub_layout = "base"
  end

  def show
    @veiculo = Veiculo.find(params[:id])
    @categoria = CategoriaDeVeiculo.find(@veiculo.categoria_de_veiculo_id)
    @sub_layout = "base"
  end

  def new
    @veiculo = Veiculo.new
    @sub_layout = "base"
  end

  def edit
    @veiculo = Veiculo.find(params[:id])
    @sub_layout = "base"
  end

  def create
    @veiculo = Veiculo.new(params[:veiculo])

    if @veiculo.save
      flash[:sucesso] = 'Veículo cadastrado com sucesso!'
      redirect_to(@veiculo)
    else
      @sub_layout = "base"
      render :action => "new"
    end
  end

  def update
    @veiculo = Veiculo.find(params[:id])

    if @veiculo.update_attributes(params[:veiculo])
      flash[:sucesso] = 'Veículo modificado com sucesso!'
      redirect_to(@veiculo)
    else
      @sub_layout = "base"
      render :action => "edit"
    end
  end

  def destroy
    @veiculo = Veiculo.find(params[:id])
    @veiculo.destroy
    @sub_layout = "base"
    redirect_to(veiculos_url)
  end
end

