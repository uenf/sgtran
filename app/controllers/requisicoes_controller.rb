class RequisicoesController < ApplicationController

  # GET /requisicoes
  # GET /requisicoes.xml


  IDA   = 0
  VOLTA = 1

  layout "sistema"

  access_control do
      allow all, :to => [:new, :create, :confirmar_requisicao, :requisicao_ja_foi_cancelada, :cancelar_requisicao, :visualizar_requisicao,
                          :cancelar_requisicao_pelo_professor]
      allow :admin, :to => [:index, :show, :aceitar, :fechar_viagem]
  end


  def index
    @requisicoes = Requisicao.all(:conditions => "estado = '" + Requisicao::ESPERA + "'", :order => "id ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requisicoes }
    end
  end

  # GET /requisicoes/1
  # GET /requisicoes/1.xml
  def show
    @requisicao = Requisicao.find(params[:id])
    @solicitante = Solicitante.find(@requisicao.solicitante_id)

    session[:requisicao] = @requisicao

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @requisicao }
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

    dados_solicitante = {:matricula => params[:matricula], :email => params[:email]}

    @verificarSolicitante = Requisicao.verificarSolicitante(dados_solicitante, params[:requisicao])

    if @verificarSolicitante.valid?

      @requisicao = Requisicao.instanciarRequisicoes(params[:requisicao], params[:data_de_reserva_ida_volta_br],
                    params[:data_de_reserva], params[:roteiro_da_agenda_volta], @verificarSolicitante.solicitante_id)
      if @requisicao.length == 1
        respond_to do |format|
          if @requisicao[IDA].save
            #incluindo linha para enviar o emailtesteuenf
            #comentado temporariamente, porta bloqueada
            @solicitante = Solicitante.find(@requisicao[IDA].solicitante_id)
            session[:requisicao] = @requisicao
            #Confirmacao.deliver_email_com_confirmacao_de_cadastro_de_requisicao(@requisicao, @solicitante)
            flash[:sucesso] = 'Requisição enviada com sucesso!'
            format.html { redirect_to(confirmar_requisicao_path) }
            format.xml  { render :xml => @requisicao, :status => :created, :location => @requisicao }
          else
            @requisicao = @requisicao[IDA]
            format.html { render :action => "new", :layout => "requisicoes" }
            format.xml  { render :xml => @requisicao.errors, :status => :processable_entity }
          end
       end

     else

       confirmacao = @requisicao[IDA].registrarVolta @requisicao[VOLTA]

        if confirmacao.valid?
            session[:requisicao] = @requisicao
            flash[:sucesso] = 'Requisição enviada com sucesso!'
            redirect_to(confirmar_requisicao_path)
        else
          @requisicao = confirmacao
          render :action => "new", :layout => "requisicoes"
        end

     end

   else
    @requisicao = @verificarSolicitante
    render :action => "new", :layout => "requisicoes"
   end

  end


  def confirmar_requisicao
    @requisicao = session[:requisicao]
    @solicitante = Solicitante.find_by_matricula_and_email(params[:matricula], params[:email])

    session.delete :requisicao
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
    @viagem       = session[:viagem]
    @requisicao   = Requisicao.find(params[:id])
    @solicitante  = Solicitante.find(@requisicao.solicitante_id)

    if @viagem.nil?
      @viagem = Viagem.new :data_partida => @requisicao.data_de_reserva, :data_chegada => @requisicao.data_de_reserva
    end

    session.delete :viagem
  end

  def fechar_viagem
    @requisicao = Requisicao.find(params[:id])

    if @requisicao.viagem_id == nil

      viagem = @requisicao.aceitar(
        Motorista.find_by_id(params[:motorista][:id]),
        data_nula(params[:data_saida]),
        data_nula(params[:data_chegada]),
        (params[:horario]["partida(4i)"].blank? and params[:horario]["partida(5i)"].blank?) ? nil : params[:horario]["partida(4i)"] + ":" + params[:horario]["partida(5i)"])

      if viagem.errors.empty?
        redirect_to :controller => "viagem", :action => "show", :id => viagem.id
      else
        session[:viagem] = viagem
        redirect_to :action => "aceitar"
      end

    else
      redirect_to :action => "show"
    end
  end

  def cancelar_requisicao_pelo_professor
    @requisicao = Requisicao.find(params[:id])
    @solicitante = Solicitante.find(@requisicao.solicitante_id)

    if @requisicao.cancelar_pelo_professor(params[:requisicao][:motivo])
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

  private

  def data_nula(str_data)
    begin
      str_data.to_date
    rescue
      nil
    end
  end

end

