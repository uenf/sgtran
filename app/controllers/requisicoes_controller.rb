class RequisicoesController < ApplicationController

  layout "sistema"

  access_control do
      allow all, :to => [:new,
                         :create,
                         :confirmar_requisicao,
                         :requisicao_ja_foi_cancelada,
                         :cancelar_requisicao,
                         :visualizar_requisicao,
                         :cancelar_requisicao_pelo_professor]
      allow :admin
      allow :visit, :to => [:index,
                            :show,
                            :filtrar]
  end


  def index
    @requisicoes = Requisicao.all(:conditions => "estado = '" + Requisicao::ESPERA + "'", :order => "id ASC")
  end

  def filtrar
    @filtro = params[:filtro]
    @requisicoes = Requisicao.filtrar(@filtro.to_s)
    render :action => "index"
  end

  def show
    @requisicao = Requisicao.find(params[:id])
    if @requisicao.blank?
      redirect_to(requisicoes_path)
    else
      @solicitante = @requisicao.solicitante
    end
  end

  def formulario_inativo
  end

  def new
    if configuracoes.formulario_ativo?
      @requisicao = Requisicao.new
      @solicitante = Solicitante.new
      render :action => "new", :layout => "front_end"
    else
      render :action => "formulario_inativo", :layout => "erros_e_avisos"
    end
  end

  def new_admin
    @requisicao = Requisicao.new
  end

  def nova_requisicao
    @requisicao = Requisicao.new(params[:requisicao])
    data = @requisicao.data_de_reserva
    celular = @requisicao.celular
    @requisicao.data_de_reserva = @requisicao.data_de_reserva ? Date.today + 2.days : ''
    @requisicao.celular = '9999-9999'

    if @requisicao.valid?
      @requisicao.data_de_reserva = data
      @requisicao.celular = celular
      @requisicao.save_with_validation false
      flash[:sucesso] = "Requisição enviada com sucesso."
      redirect_to(@requisicao)
    else
      render :action => "new_admin"
    end
  end

  def create
    @requisicao = Requisicao.new(params[:requisicao])
    @solicitante = Solicitante.new(params[:solicitante])

    if @requisicao.analisar_requisicao @solicitante
      @requisicao.reload
      session[:requisicao] = @requisicao.id
      Confirmacao.deliver_email_confirmacao_de_cadastro_de_requisicao(@requisicao)
      redirect_to(confirmar_requisicao_path)
    else
      render :action => "new", :layout => "front_end"
    end
  end

  def destroy
    @requisicao = Requisicao.find(params[:id])
    @requisicao.destroy
    flash[:sucesso] = "Requisição excluída com sucesso."
    redirect_to(requisicoes_path)
  end


  def confirmar_requisicao
    if not session[:requisicao].nil?
      @requisicao = Requisicao.find(session[:requisicao])
      session.delete :requisicao
      @solicitante = Solicitante.find_by_matricula_and_email(params[:matricula], params[:email])
      flash[:sucesso] = "Requisição enviada com sucesso!"
      render :action => "confirmar_requisicao", :layout => "front_end"
    else
      redirect_to(new_requisicao_path)
    end
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
        render :action => "requisicao_ja_foi_cancelada", :layout => "front_end"
      else
        @solicitante = Solicitante.find(@requisicao.solicitante_id)
        render :action => "cancelar_requisicao",
               :chave_de_seguranca => params[:chave_de_seguranca],
               :id => params[:id],
               :layout => "front_end"
      end

    rescue ActiveRecord::RecordNotFound
      redirect_to :action => "new"
    end
  end

  def cancelar_requisicao_pelo_professor
    @requisicao = Requisicao.find(params[:id])
    @solicitante = Solicitante.find(@requisicao.solicitante_id)

    if @requisicao.cancelar_pelo_professor(params[:requisicao][:motivo_professor])
      render :layout => "front_end"
      session[:requisicao] = @requisicao
      #incluindo linha para enviar o emailtesteuenf para ailton informando que professor cancelou a requisição
      Confirmacao.deliver_email_cancelamento_professor(@requisicao)
    else
      render :action => "cancelar_requisicao", :layout => "front_end"
    end
  end

  def requisicao_ja_foi_cancelada
  end

  def visualizar_requisicao
    begin
      @requisicao = Requisicao.find(params[:id])

      #bloqueia acesso caso chave nao esteja correta, redirecionando para nova requisição
      if @requisicao.chave_de_seguranca != params[:chave_de_seguranca]
        raise ActiveRecord::RecordNotFound
      end

      @solicitante = Solicitante.find(@requisicao.solicitante_id)
      render :action => "visualizar_requisicao",
             :chave_de_seguranca => params[:chave_de_seguranca],
             :id => params[:id],
             :layout => "front_end"

    rescue ActiveRecord::RecordNotFound
      redirect_to :action => "new"
    end
  end

  def aceitar
    if session[:requisicao]
      @requisicao = Requisicao.find(session[:requisicao][:id])
      @requisicao.errors.add(:viagem, session[:requisicao][:erro].to_s)
      session.delete :requisicao
    else
      @requisicao = Requisicao.find(params[:id])
    end
    if @requisicao.pode_ser_aceita?
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
      if session[:viagem]
        @viagem = session[:viagem]
        session.delete :viagem
      else
        @viagem = Viagem.new :data_partida => @requisicao.data_de_reserva, :data_chegada => @requisicao.data_de_reserva
      end
      @viagens = Viagem.find_all_by_estado(Viagem::AGUARDANDO)
      render :action => "aceitar"
    else
      @solicitante = Solicitante.find(@requisicao.solicitante_id)
      flash[:erro] = "A requisição deve estar no estado 'Em Espera' para ser aceita."
      redirect_to(requisicao_path(@requisicao))
    end
  end

  def fechar_viagem
    @requisicao = Requisicao.find(params[:id])
    corpo_do_email = params[:corpo_do_email]
    destinatarios = params[:destinatarios]

    if params[:escolha_de_viagem].eql?("nova")

      @viagem = Viagem.new :motorista_ids => params[:motorista_ids],
                          :veiculo_id => params[:veiculo_id],
                          :data_partida => data_nula(params[:data_saida]),
                          :data_chegada => data_nula(params[:data_chegada]),
                          :horario_partida => (params[:horario]["partida(4i)"] and params[:horario]["partida(5i)"]) ?
                              params[:horario]["partida(4i)"] + ":" + params[:horario]["partida(5i)"] : nil

      if @viagem.valid?
        @viagem.save!
        @requisicao.aceitar @viagem
        Confirmacao.deliver_enviar_email_aceitar(corpo_do_email, destinatarios, @requisicao) if not params[:email]
        redirect_to :controller => "viagem", :action => "show", :id => @viagem.id
      else
        session[:viagem] = @viagem
        redirect_to :action => "aceitar"
      end

    elsif params[:escolha_de_viagem].eql?("existente")
      if params[:id_da_viagem]
        @viagem = @requisicao.aceitar_com_viagem_existente(params[:id_da_viagem])
        if @viagem
          Confirmacao.deliver_enviar_email_aceitar(corpo_do_email, destinatarios, @requisicao) if not params[:email]
          redirect_to :controller => "viagem", :action => "show", :id => @viagem.id
        else
          session[:requisicao] = {:id => @requisicao.id, :erro => " não foi selecionada."}
          redirect_to :action => "aceitar"
        end
      else
        session[:requisicao] = {:id => @requisicao.id, :erro =>  " não foi selecionada."}
        redirect_to :action => "aceitar"
      end

    else
      redirect_to :action => "show"
    end
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
    @motivos = Motivo.find_all_by_status(Motivo::ATIVO)
  end

  def rejeitar_requisicao
    @requisicao = Requisicao.find(params[:requisicao])
    motivo = params[:motivo]
    corpo_email = params[:corpo_email]
    destinatarios = params[:destinatarios]
    if @requisicao.rejeitar(motivo)
      Confirmacao.deliver_enviar_email(corpo_email, destinatarios, @requisicao)
      redirect_to requisicao_path(@requisicao)
    else
      flash[:erro] = "Erro ao rejeitar a requisição. " + @requisicao.errors.full_messages.to_sentence
      @solicitante = Solicitante.find(@requisicao.solicitante_id)
      @motivos = Motivo.all
      render :action => "rejeitar"
    end
  end

  def cancelar_requisicao_pelo_sistema
    @motivos = Motivo.find_all_by_status(Motivo::ATIVO)
    @requisicao = Requisicao.find(params[:id])
    @solicitante = Solicitante.find(@requisicao.solicitante_id)
  end

  def cancelar_pelo_sistema
    @requisicao = Requisicao.find(params[:requisicao_id])
    motivo = params[:motivo]
    corpo_do_email = params[:corpo_email]
    destinatarios = params[:destinatarios]

    if @requisicao.esta_aceita?
      retorno = @requisicao.cancelar_requisicao motivo.to_i, corpo_do_email, destinatarios
      Confirmacao.deliver_enviar_email(corpo_do_email, destinatarios, @requisicao) if retorno
    else
      flash[:erro] = "A requisição deve estar no estado 'Aceita' para ser cancelada."
    end
    redirect_to(@requisicao)
  end

  def alterar_viagem
    @requisicao = Requisicao.find(params[:id]) if params[:id]
    @viagens = Viagem.find_all_by_estado(Viagem::AGUARDANDO)
  end

  def alterar
    @requisicao = Requisicao.find(params[:requisicao_id]) if params[:requisicao_id]
    viagem_id = params[:id_da_viagem]
    if viagem_id
      if @requisicao.alterar_viagem viagem_id
        redirect_to(viagem_path(viagem_id))
      else
        flash[:erro] = "Erro ao alterar viagem."
        rendre :action => "alterar_viagem"
      end
    else
      @viagens = Viagem.find_all_by_estado(Viagem::AGUARDANDO)
      flash[:erro] = "Escolha uma viagem."
      render :action => "alterar_viagem"
      flash[:erro] = ""
    end
  end

  def buscar_requisicao
    dados = params[:busca]
    if dados == "Data"
      @inicio = params[:inicio]
      @fim    = params[:fim]
      @requisicoes = Requisicao.buscar_por_data(@inicio, @fim)
    elsif dados == "Nome"
      @nome = params[:nome]
      @requisicoes = Requisicao.buscar_por_nome_de_solicitante @nome
    elsif dados == "Protocolo"
      @protocolo = params[:protocolo]
      @requisicoes = Requisicao.buscar_por_protocolo(@protocolo)
    else
      @requisicoes = Requisicao.find_all_by_estado(Requisicao::ESPERA)
    end
    render :action => :index

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

