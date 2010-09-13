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
    @requisicoes_ids = @viagem.requisicao_ids
    @motorista = @viagem.motoristas
    @veiculo = Veiculo.find(@viagem.veiculo_id)
  end

  def new
    @bdt = Bdt.new
    @viagem = Viagem.find(params[:id])
    @requisicoes_ids = @viagem.requisicao_ids
    @motoristas = @viagem.motoristas
    @veiculo = Veiculo.find(@viagem.veiculo_id)
  end

  def edit
    @bdt = Bdt.find(params[:id])
    @viagem = Viagem.find(@bdt.viagem_id)
    @requisicoes_ids = @viagem.requisicao_ids
    @motorista = @viagem.motoristas
    @veiculo = Veiculo.find(@viagem.veiculo_id)
  end

  def create
    @bdt = Bdt.new(params[:bdt])
    @viagem = Viagem.find(params[:viagem_id])
    @requisicoes_ids = @viagem.requisicao_ids
    dados_viagem = {:veiculo_id => params[:veiculo][:id],
                    :motorista_ids => params[:motorista][:ids],
                    :viagem_id => params[:viagem_id]}

    if @bdt.salvar dados_viagem
      cidades_origem = params[:cidade_origem]
      cidades_destino = params[:cidade_destino]
      Requisicao.atualizar_origem_destino(cidades_origem, cidades_destino)
      flash[:sucesso] = 'Bdt criado com sucesso.'
      redirect_to(@bdt)
    else
      @viagem = Viagem.find(dados_viagem[:viagem_id])
      @motoristas = @viagem.motoristas
      @veiculo = Veiculo.find(@viagem.veiculo_id)
      render :action => "new"
    end
  end

  def update
    @bdt = Bdt.find(params[:id])

    dados_viagem = {:veiculo_id => params[:veiculo][:id],
                    :motorista_ids => params[:motorista][:ids],
                    :viagem_id => params[:viagem_id]}

    if @bdt.atualizar params[:bdt], dados_viagem
      cidades_origem = params[:cidade_origem]
      cidades_destino = params[:cidade_destino]
      Requisicao.atualizar_origem_destino(cidades_origem, cidades_destino)
      flash[:sucesso] = 'BDT atualizado com sucesso.'
      redirect_to(@bdt)
    else
      @viagem = Viagem.find(dados_viagem[:viagem_id])
      @requisicoes_ids = @viagem.requisicao_ids
      @motorista = Motorista.find(@viagem.motorista_id)
      @veiculo = Veiculo.find(@viagem.veiculo_id)
      render :action => "edit"
    end
  end

  def destroy
    @bdt = Bdt.find(params[:id])
    @bdt.destroy
    redirect_to(bdts_url)
  end

  def carregar_cidades_origem
    if not params[:estado_id].blank?
      @id = params[:requisicao_id]
	    @estado = Estado.find(params[:estado_id])
	    @cidades_origem = @estado.cidades
	    render :layout => false
	  else
	    @id = params[:requisicao_id]
	    @cidades_origem = []
	    render :layout => false
    end
  end

  def carregar_cidades_destino
    if not params[:estado_id].blank?
      @id = params[:requisicao_id]
	    @estado = Estado.find(params[:estado_id])
	    @cidades_destino = @estado.cidades
	    render :layout => false
	  else
	    @id = params[:requisicao_id]
	    @cidades_destino = []
	    render :layout => false
    end
  end

end

