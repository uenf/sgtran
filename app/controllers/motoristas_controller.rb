class MotoristasController < ApplicationController
  access_control do
    allow :admin
    allow :visit, :to => [:index, :show]
  end

  layout "sistema"

  def index
    @motoristas = Motorista.all(:order => "nome ASC")
    @sub_layout = "base"
  end

  def show
    @motorista = Motorista.find(params[:id])
    @sub_layout = "base"
  end

  def new
    @motorista = Motorista.new
    @sub_layout = "base"
  end

  def edit
    @motorista = Motorista.find(params[:id])
    @sub_layout = "base"
  end

  def create
    @motorista = Motorista.new(params[:motorista])

    if @motorista.save
      flash[:sucesso] = 'Motorista criado com sucesso!'
      redirect_to(@motorista)
    else
      @sub_layout = "base"
      render :action => "new"
    end
  end

  def update
    @motorista = Motorista.find(params[:id])

    if @motorista.update_attributes(params[:motorista])
      flash[:sucesso] = 'Motorista modificado com sucesso!'
      redirect_to(@motorista)
    else
      @sub_layout = "base"
      render :action => "edit"
    end
  end

  def destroy
    @motorista = Motorista.find(params[:id])
    @motorista.destroy
    @sub_layout = "base"
    redirect_to(motoristas_url)
  end

  def vencimento_cnh
    @motoristas = Motorista.para_aviso_cnh
  end

  def retirar_aviso_cnh
    @motoristas = Motorista.vence_cnh_em(30.days)

    @motoristas.each do |motorista_id|
      Motorista.find(motorista_id).avisar_vencimento_cnh
    end
    redirect_to :controller => "requisicoes", :action => "index"
  end
end

