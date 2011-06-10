require "brazilian-rails"

class ViagensController < ApplicationController

  access_control do
    allow :admin
    allow :visit, :to => [:index, :filtrar, :show, :viagens_existentes, :buscar_viagem]
  end

  layout "sistema"

  def index
    @viagens = []
  end

  def filtrar
    @filtro = params[:filtro]
    @viagens = Viagem.filtrar(@filtro)
    render :action => "index"
  end

  def show
    @viagem = Viagem.find(params[:id])
    @veiculo = Veiculo.find(@viagem.veiculo_id) if not @viagem.veiculo_id.nil?
  end

  def new
    @viagem = Viagem.new
  end

  def edit
    @viagem = Viagem.find(params[:id])
    data_partida = @viagem.data_partida
    data_chegada = @viagem.data_chegada
    if @viagem.veiculo_id
      @categoria_de_veiculo_id = Veiculo.find(@viagem.veiculo_id).categoria_de_veiculo_id
    else
      @categoria_de_veiculo_id = nil
    end
    @lista_motoristas = [
                          ['Motoristas desocupados', Motorista.desocupados_entre(data_chegada,data_partida)],
                          ['Motoristas ocupados', Motorista.ocupados_entre(data_chegada,data_partida)]
                        ]
    @lista_veiculos = [
                        ['Veículos desocupados', Veiculo.desocupados_entre_datas_e_com_categoria(data_chegada,data_partida,@categoria_de_veiculo_id)],
                        ['Veículos ocupados', Veiculo.ocupados_entre_datas_e_com_categoria(data_chegada,data_partida,@categoria_de_veiculo_id)]
                      ]
  end

  def create
    @viagem = Viagem.new(params[:viagem])

    if @viagem.save
      flash[:notice] = 'Viagem was successfully created.'
      redirect_to(@viagem)
    else
      render :action => "new"
    end
  end

  def update
    @viagem = Viagem.find(params[:id])
    params[:viagem][:data_partida] = data_str_ou_nil(params[:viagem][:data_partida])
    params[:viagem][:data_chegada] = data_str_ou_nil(params[:viagem][:data_chegada])

    @viagem.attributes = params[:viagem]
    @viagem.save_with_validation false
    flash[:sucesso] = 'Viagem atualizada com sucesso!'
    redirect_to(@viagem)
  end

  def destroy
    @viagem = Viagem.find(params[:id])
    @viagem.destroy
    redirect_to(viagens_url)
  end

  def cancelar_viagem
    @viagem = Viagem.find(params[:id])
    @veiculo = Veiculo.find(@viagem.veiculo_id) if not @viagem.veiculo_id.nil?
    if !@viagem.esta_aguardando?
      flash[:erro] = "A viagem deve possuir o estado 'Aguardando' para ser cancelada."
      redirect_to(@viagem)
    end
  end

  def cancelamento_da_viagem
    motivo = params[:viagem][:motivo_id]
    @viagem = Viagem.find(params[:viagem_id])
    @viagem.cancelar_viagem motivo.to_i
    redirect_to(viagens_path)
  end

  def opcoes_motoristas
    data_partida, data_chegada = params[:viagem][:data_partida].to_date, params[:viagem][:data_chegada].to_date
    @lista_motoristas = [
                          ['Motoristas desocupados', Motorista.desocupados_entre(data_partida,data_chegada)],
                          ['Motoristas ocupados', Motorista.ocupados_entre(data_partida,data_chegada)]
                        ]
    render :partial => 'opcoes_motoristas', :object => @lista_motoristas
  end

  def opcoes_veiculos
    data_partida, data_chegada = params[:viagem][:data_partida].to_date, params[:viagem][:data_chegada].to_date
    categoria_de_veiculo_id = Veiculo.find(params[:viagem][:veiculo_id]).categoria_de_veiculo_id
    @lista_veiculos = [
                        ['Veículos desocupados', Veiculo.desocupados_entre_datas_e_com_categoria(data_chegada,data_partida,categoria_de_veiculo_id)],
                        ['Veículos ocupados', Veiculo.ocupados_entre_datas_e_com_categoria(data_chegada,data_partida,categoria_de_veiculo_id)]
                      ]
    render :partial => 'opcoes_veiculos', :object => @lista_veiculos
  end

  def buscar_viagem
    if params[:busca] == "Data de partida"
      @data_de_partida = params[:data_de_partida]
      @viagens = Viagem.buscar_por_data_de_partida(@data_de_partida)
    elsif params[:busca] == "Data de chegada"
      @data_de_chegada = params[:data_de_chegada]
      @viagens = Viagem.buscar_por_data_de_chegada(@data_de_chegada)
    elsif params[:busca] == "Motorista"
      @motorista = params[:motorista]
      @viagens = Viagem.buscar_por_motorista(@motorista)
    elsif params[:busca] == "Placa"
      @placa = params[:placa]
      @viagens = Viagem.buscar_por_placa(@placa)
    else
      @viagens = Viagem.all
    end
    render :action => "index"
  end

  def data_str_ou_nil(str_data)
    begin
      str_data.to_date
    rescue
      Date.today
    end
  end

  def viagens_sem_bdt
    @viagens = []
    lista_de_viagens = Viagem.find_all_by_estado(Viagem::ATENDIDA, :order => "data_partida DESC")
    lista_de_viagens.each do |viagem|
      @viagens << viagem if Bdt.find_by_viagem_id(viagem.id).nil?
    end
  end

end

