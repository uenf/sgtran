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
    viagem = Viagem.find(params[:id])
    @motorista = Motorista.find(viagem.motorista_id)
    @veiculo = Veiculo.find(viagem.veiculo_id)
    @bdt = Bdt.new
  end

  def edit
    @bdt = Bdt.find(params[:id])
  end

  def create
    @bdt = Bdt.new(params[:bdt])

    if @bdt.save
      flash[:notice] = 'Bdt was successfully created.'
      redirect_to(@bdt)
    else
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

