class BdtsController < ApplicationController

  access_control do
    allow :admin
    allow :visit, :to => [:index, :show]
  end

  def index
    @bdts = Bdt.all
  end

  def show
    @bdt = Bdt.find(params[:id])
  end

  def new
    @viagem = Viagem.find(params[:id])
    @motorista = Motorista.find(@viagem.motorista_id)
    @veiculo = Veiculo.find(@viagem.veiculo_id)
    @bdt = Bdt.new
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
                    :id => params[:viagem_id]}
    if @bdt.salvar dados_viagem
      flash[:notice] = 'Bdt criado com sucesso.'
      redirect_to(@bdt)
    else
      @viagem = Viagem.find(params[:viagem_id])
      @motorista = Motorista.find(params[:motorista][:id])
      @veiculo = Veiculo.find(params[:veiculo][:id])
      render :action => "new"
    end
  end

  def update
    @bdt = Bdt.find(params[:id])

    if @bdt.update_attributes(params[:bdt])
      flash[:notice] = 'Bdt was successfully updated.'
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

