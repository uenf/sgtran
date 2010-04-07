class RequisicoesController < ApplicationController

  # GET /requisicoes
  # GET /requisicoes.xml


  IDA   = 0
  VOLTA = 1

  layout "sistema"

  access_control do
      allow all, :to => [:new,
                         :create,
                         :confirmar_requisicao,
                         :requisicao_ja_foi_cancelada,
                         :cancelar_requisicao,
                         :visualizar_requisicao,
                         :cancelar_requisicao_pelo_professor]
      allow :admin, :to => [:index,
                            :show,
                            :aceitar,
                            :fechar_viagem,
                            :filtrar,
                            :rejeitar,
                            :rejeitar_requisicao,
                            :cancelar_requisicao_pelo_sistema,
                            :cancelar_pelo_sistema,
                            :base_de_dados,
                            :opcoes_veiculos,
                            :opcoes_motoristas]
      allow :visit, :to => [:index,
                            :show,
                            :filtrar]
  end


  def index
    @requisicoes = Requisicao.all(:conditions => "estado = '" + Requisicao::ESPERA + "'", :order => "id ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requisicoes }
    end
  end

  def filtrar
    @filtro = params[:filtro]
    @requisicoes = Requisicao.filtrar(@filtro.to_s)
    render :action => "index"
  end

  # GET /requisicoes/1
  # GET /requisicoes/1.xml
  def show
    @requisicao = Requisicao.find(params[:id])
    if @requisicao.blank?
      redirect_to(requisicoes_path)
    else
      @solicitante = Solicitante.find(@requisicao.solicitante_id)

      session[:requisicao] = @requisicao

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @requisicao }
      end
    end
  end

  # GET /requisicoes/new
  # GET /requisicoes/new.xml
  def new
    @requisicao = Requisicao.new
    render :action => "new", :layout => "requisicoes"
  end

  # POST /requisicoes
  # POST /requisicoes.xml

  def create
    if params[:data_de_reserva] == "volta"
      dados = {:matricula => params[:matricula],
                :email => params[:email],
                :requisicao => params[:requisicao],
                :roteiro_da_agenda_volta => params[:roteiro_da_agenda_volta],
                :data_de_reserva_ida_volta => params[:data_de_reserva_ida_volta_br],
                :tipo => "Ida e Volta"}
    else
      dados = {:matricula => params[:matricula], :email => params[:email], :requisicao => params[:requisicao], :tipo => "Ida"}
    end
    @requisicao = Requisicao.analisar_requisicao dados
    if @requisicao.length == 1
      if @requisicao[IDA].valid?
        session[:requisicao] = @requisicao
        redirect_to(confirmar_requisicao_path)
      else
        @requisicao = @requisicao[IDA]
        render :action => "new", :layout => "requisicoes"
      end
    else
      if @requisicao[IDA].valid?
        if @requisicao[VOLTA].valid?
          session[:requisicao] = @requisicao
          redirect_to(confirmar_requisicao_path)
        else
          @requisicao = @requisicao[VOLTA]
          render :action => "new", :layout => "requisicoes"
        end
      else
        @requisicao = @requisicao[IDA]
        render :action => "new", :layout => "requisicoes"
      end
    end
#   Confirmacao.deliver_email_com_confirmacao_de_cadastro_de_requisicao(@requisicao, @solicitante)
  end


  def confirmar_requisicao
    @requisicao = session[:requisicao]
    @solicitante = Solicitante.find_by_matricula_and_email(params[:matricula], params[:email])

    session.delete :requisicao
    flash[:sucesso] = "Requisição enviada com sucesso!"
    render :action => "confirmar_requisicao", :layout => "requisicoes"
  end

  def cancelar_requisicao
    begin
      @requisicao = Requisicao.find(params[:id])

      #bloqueia acesso caso chave nao esteja correta, redirecionando para nova requisição
      if @requisicao.chave_de_seguranca != params[:chave_de_seguranca]
        raise ActiveRecord::RecordNotFound
      end

      #checa se a requisição já foi cancelada
      if @requisicao.estado == Requisicao::CANCELADO_PELO_PROFESSOR
        render :action => "requisicao_ja_foi_cancelada", :layout => "requisicoes"
      else
        @solicitante = Solicitante.find(@requisicao.solicitante_id)
        render :action => "cancelar_requisicao", :id => params[:id], :chave_de_seguranca => params[:chave_de_seguranca], :layout => "requisicoes"
      end

    rescue ActiveRecord::RecordNotFound
      redirect_to :action => "new"
    end
  end

  def visualizar_requisicao
    begin
      @requisicao = Requisicao.find(params[:id])

      #bloqueia acesso caso chave nao esteja correta, redirecionando para nova requisição
      if @requisicao.chave_de_seguranca != params[:chave_de_seguranca]
        raise ActiveRecord::RecordNotFound
      end

      @solicitante = Solicitante.find(@requisicao.solicitante_id)
      render :action => "visualizar_requisicao", :id => params[:id], :chave_de_seguranca => params[:chave_de_seguranca], :layout => "requisicoes"

    rescue ActiveRecord::RecordNotFound
      redirect_to :action => "new"
    end
  end

  def aceitar
    @requisicao = session[:requisicao] ? session[:requisicao] : Requisicao.find(params[:id])
    if @requisicao.esta_em_espera? or @requisicao.esta_rejeitada?
      data = @requisicao.data_de_reserva
      @lista_motoristas = [
                            ['Motoristas desocupados', Motorista.desocupados_entre(data,data)],
                            ['Motoristas ocupados', Motorista.ocupados_entre(data,data)]
                          ]
      @lista_veiculos = [
                          ['Veículos desocupados', Veiculo.desocupados_entre_datas_e_com_categoria(data,data,@requisicao.categoria_de_veiculo_id)],
                          ['Veículos ocupados', Veiculo.ocupados_entre_datas_e_com_categoria(data,data,@requisicao.categoria_de_veiculo_id)]
                        ]
      @solicitante  = Solicitante.find(@requisicao.solicitante_id)

      @viagem = session[:viagem]
      if @viagem.nil?
        @viagem = Viagem.new :data_partida => @requisicao.data_de_reserva, :data_chegada => @requisicao.data_de_reserva
      end
      session.delete :viagem

      @viagens = Viagem.all
      render :action => "aceitar"
    else
      @solicitante = Solicitante.find(@requisicao.solicitante_id)
      flash[:erro] = "A requisição deve estar no estado 'Em Espera' para ser aceita."
      redirect_to(requisicao_path(@requisicao))
    end
  end

  def fechar_viagem
    @requisicao = Requisicao.find(params[:id])

    if @requisicao.viagem_id == nil && params[:escolha_de_viagem].eql?("nova")

      viagem = @requisicao.aceitar(
        Motorista.find_by_id(params[:motorista_id]),
        Veiculo.find_by_id(params[:veiculo_id]),
        data_nula(params[:data_saida]),
        data_nula(params[:data_chegada]),
        (params[:horario]["partida(4i)"].blank? and params[:horario]["partida(5i)"].blank?) ? nil : params[:horario]["partida(4i)"] + ":" + params[:horario]["partida(5i)"])

      if viagem
        if viagem.valid?
          redirect_to :controller => "viagem", :action => "show", :id => viagem.id
        else
          session[:viagem] = viagem
          redirect_to :action => "aceitar"
        end
      end

    elsif params[:escolha_de_viagem].eql?("existente")
      if not params[:id_da_viagem].blank?
        viagem = @requisicao.aceitar_com_viagem_existente(params[:id_da_viagem])
        redirect_to :controller => "viagem", :action => "show", :id => viagem.id
      else
        @requisicao.errors.add(:viagem, "não foi selecionada.")
        session[:requisicao] = @requisicao
        redirect_to :action => "aceitar"
      end

    else
      redirect_to :action => "show"
    end
  end

  def cancelar_requisicao_pelo_professor
    @requisicao = Requisicao.find(params[:id])
    @solicitante = Solicitante.find(@requisicao.solicitante_id)

    if @requisicao.cancelar_pelo_professor(params[:requisicao][:motivo_professor])
      flash[:sucesso] = 'Requisição cancelada com sucesso!'
      session[:requisicao] = @requisicao
      #incluindo linha para enviar o emailtesteuenf para ailton informando que professor cancelou a requisição
      #comentado temporariamente, porta bloqueada
      #Confirmacao.deliver_email_informando_astran_sobre_cancelamento(@requisicao)
    else
      render :action => "cancelar_requisicao", :layout => "requisicoes"
    end
  end

  def requisicao_ja_foi_cancelada
  end

  def regras
    render :layout => "regras"
  end

  def opcoes_motoristas
    data_partida, data_chegada = params[:data_partida].to_date, params[:data_chegada].to_date
    @lista_motoristas = [
                          ['Motoristas desocupados', Motorista.desocupados_entre(data_partida,data_chegada)],
                          ['Motoristas ocupados', Motorista.ocupados_entre(data_partida,data_chegada)]
                        ]
    render :partial => 'opcoes_motoristas', :object => @lista_motoristas
  end

  def opcoes_veiculos
    data_partida, data_chegada = params[:data_partida].to_date, params[:data_chegada].to_date
    categoria_de_veiculo_id = params[:categoria_de_veiculo_id].to_i
    @lista_veiculos = [
                        ['Veículos desocupados', Veiculo.desocupados_entre_datas_e_com_categoria(data_chegada,data_partida,categoria_de_veiculo_id)],
                        ['Veículos ocupados', Veiculo.ocupados_entre_datas_e_com_categoria(data_chegada,data_partida,categoria_de_veiculo_id)]
                      ]
    render :partial => 'opcoes_veiculos', :object => @lista_veiculos
  end

  def rejeitar
    @requisicao = Requisicao.find(params[:id])
    @solicitante = Solicitante.find(@requisicao.solicitante_id)
    @motivos = Motivo.all
  end

  def rejeitar_requisicao
    @requisicao = Requisicao.find(params[:requisicao])
    motivo = params[:motivo]
    observacao = params[:motivo_observacao]
    @requisicao.rejeitar motivo, observacao
    redirect_to requisicao_path(@requisicao)
  end

  def cancelar_requisicao_pelo_sistema
    @motivos = Motivo.all
    @requisicao = Requisicao.find(params[:id])
    @solicitante = Solicitante.find(@requisicao.solicitante_id)
  end

  def cancelar_pelo_sistema
    @requisicao = Requisicao.find(params[:requisicao_id])
    motivo = params[:motivo]
    observacao = params[:motivo_observacao]
    if @requisicao.esta_aceita?
      @requisicao.cancelar_requisicao motivo.to_i, observacao.to_s
      redirect_to(requisicao_path(@requisicao))
    else
      flash[:erro] = "A requisição deve estar no estado 'Aceita' para ser cancelada."
      redirect_to(requisicao_path(@requisicao))
    end
  end

  private

  def data_nula(str_data)
    begin
      str_data.to_date
    rescue
      nil
    end
  end

  def base_de_dados
  end

end

