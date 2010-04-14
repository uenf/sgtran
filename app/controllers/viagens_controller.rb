class ViagensController < ApplicationController
  # GET /viagens
  # GET /viagens.xml

  access_control do
    allow :admin
    allow :visit, :to => [:index, :filtrar, :show, :viagens_existentes]
  end

  layout "sistema"

  def index
    @viagens = Viagem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @viagens }
    end
  end

  def filtrar
    @filtro = params[:filtro]
    @viagens = Viagem.filtrar(@filtro)
    render :action => "index"

  end

  # GET /viagens/1
  # GET /viagens/1.xml
  def show
    @viagem = Viagem.find(params[:id])
    @motorista = Motorista.find(@viagem.motorista_id) if not @viagem.motorista_id.nil?
    @veiculo = Veiculo.find(@viagem.veiculo_id) if not @viagem.veiculo_id.nil?

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @viagem }
    end
  end

  # GET /viagens/new
  # GET /viagens/new.xml
  def new
    @viagem = Viagem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @viagem }
    end
  end

  # GET /viagens/1/edit
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

  # POST /viagens
  # POST /viagens.xml
  def create
    @viagem = Viagem.new(params[:viagem])

    respond_to do |format|
      if @viagem.save
        flash[:notice] = 'Viagem was successfully created.'
        format.html { redirect_to(@viagem) }
        format.xml  { render :xml => @viagem, :status => :created, :location => @viagem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @viagem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /viagens/1
  # PUT /viagens/1.xml
  def update
    @viagem = Viagem.find(params[:id])
    params[:viagem][:data_partida] = data_str_ou_nil(params[:viagem][:data_partida])
    params[:viagem][:data_chegada] = data_str_ou_nil(params[:viagem][:data_chegada])
    # Apenas para colocar valores válidos para a data ligada ao horário
    params[:viagem]["horario_partida(1i)"] = Date.today.year.to_s
    params[:viagem]["horario_partida(2i)"] = Date.today.mon.to_s
    params[:viagem]["horario_partida(3i)"] = Date.today.day.to_s

    if @viagem.update_attributes(params[:viagem])
      flash[:sucesso] = 'Viagem atualizada com sucesso!'
      redirect_to(@viagem)
    else
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
      render :action => "edit"
    end
  end

  # DELETE /viagens/1
  # DELETE /viagens/1.xml
  def destroy
    @viagem = Viagem.find(params[:id])
    @viagem.destroy

    respond_to do |format|
      format.html { redirect_to(viagens_url) }
      format.xml  { head :ok }
    end
  end

  def cancelar_viagem
    @viagem = Viagem.find(params[:id])
    @motorista = Motorista.find(@viagem.motorista_id) if not @viagem.motorista_id.nil?
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

  def fechar_viagem
    @viagem = Viagem.find(params[:id]) if params[:id]
  end

  def fechar
    viagem_id = params[:viagem]
    @viagem = Viagem.find(viagem_id)
    if @viagem.fechar_viagem
      redirect_to(@viagem)
    else
      flash[:erro] = "Erro ao fechar a viagem. Verifique os dados da viagem."
      render :action => "fechar_viagem"
    end
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

  def data_str_ou_nil(str_data)
    begin
      str_data.to_date
    rescue
      Date.today
    end
  end

end

