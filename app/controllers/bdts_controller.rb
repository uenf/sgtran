class BdtsController < ApplicationController

  access_control do
    allow :admin
    allow :visit, :to => [:index, :show]
  end

  layout 'sistema'

  def index
    @bdts = Bdt.all
  end

  def show
    @bdt = Bdt.find(params[:id])
    @viagem = Viagem.find(@bdt.viagem_id)
    @motorista = Motorista.find(@viagem.motorista_id)
    @veiculo = Veiculo.find(@viagem.veiculo_id)
  end

  def new
    @bdt = Bdt.new
    @viagem = Viagem.find(params[:id])
    @motorista = Motorista.find(@viagem.motorista_id)
    @veiculo = Veiculo.find(@viagem.veiculo_id)
  end

  def edit
    @bdt = Bdt.find(params[:id])
    @viagem = Viagem.find(@bdt.viagem_id)
    @motorista = Motorista.find(@viagem.motorista_id)
    @veiculo = Veiculo.find(@viagem.veiculo_id)
  end

  def create
    @bdt = Bdt.new(params[:bdt])
    dados_viagem = {:veiculo_id => params[:veiculo][:id],
                                          :motorista_id => params[:motorista][:id],
                                          :viagem_id => params[:viagem_id]}
    if @bdt.salvar dados_viagem
      flash[:sucesso] = 'Bdt criado com sucesso.'
      redirect_to(@bdt)
    else
      @viagem = Viagem.find(dados_viagem[:viagem_id])
      @motorista = Motorista.find(@viagem.motorista_id)
      @veiculo = Veiculo.find(@viagem.veiculo_id)
      render :action => "new"
    end
  end

  def update
    @bdt = Bdt.find(params[:id])
    dados_viagem = {:veiculo_id => params[:veiculo][:id],
                    :motorista_id => params[:motorista][:id],
                    :viagem_id => params[:viagem_id]}
    if @bdt.atualizar params[:bdt], dados_viagem
      flash[:sucesso] = 'BDT atualizado com sucesso.'
      redirect_to(@bdt)
    else
      render :action => "edit"
    end
  end

  def destroy
    @bdt = Bdt.find(params[:id])
    @bdt.destroy
    redirect_to(bdts_url)
  end
end

