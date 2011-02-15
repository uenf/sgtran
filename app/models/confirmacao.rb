class Confirmacao < ActionMailer::Base


  helper do
    def saudacao
      hora = Time.now.strftime("%H")
      hora = hora.to_i
      if hora >= 00 and hora < 12
        return "Bom dia"
      elsif hora >= 12 and hora < 18
        return "Boa tarde"
      elsif hora >= 18 and hora < 00
        return "Boa noite"
      end
    end

    def endereco
      "http://www.astran.uenf.br"
    end

  end

  def configuracoes
    @configuracao ||= Configuracao.all.first
    @configuracao
  end

  def enviar_email(corpo_do_email, destinatarios, requisicao)
    #********** falta setar aqui o email correto que ailton deseja receber os avisos **********
    solicitante = Solicitante.find(requisicao.solicitante_id)
    destinatarios = destinatarios.split(";") if destinatarios

    recipients solicitante.email
    cc configuracoes.email
    bcc destinatarios if destinatarios
    from "Astran <#{configuracoes.email}>"
    subject "Reserva de Veículo - Protocolo n. #{requisicao.id}"
    sent_on Time.now # hora de envio do email
    # objetos que serão passados para o helper do template
    body :requisicao => requisicao, :corpo_do_email => corpo_do_email, :configuracoes => Configuracao.all.first
    content_type "text/html"
    template "email_padrao" # informa qual template será utilizado
  end

  def enviar_email_aceitar(corpo_do_email, destinatarios, requisicao)
    #********** falta setar aqui o email correto que ailton deseja receber os avisos **********
    solicitante = Solicitante.find(requisicao.solicitante_id)
    destinatarios = destinatarios.split(";") if destinatarios
    recipients solicitante.email
    cc configuracoes.email
    bcc destinatarios if destinatarios
    from "Astran <#{configuracoes.email}>"
    subject "Reserva de Veículo - Protocolo n. #{requisicao.id}"
    sent_on Time.now # hora de envio do email
    # objetos que serão passados para o helper do template
    body :requisicao => requisicao, :corpo_do_email => corpo_do_email, :configuracoes => Configuracao.all.first
    content_type "text/html"
    template "email_padrao_aceitar" # informa qual template será utilizado
  end

  def email_confirmacao_de_cadastro_de_requisicao(requisicao)
    solicitante = Solicitante.find(requisicao.solicitante_id)
    recipients solicitante.email
    cc configuracoes.email
    from "Astran <#{configuracoes.email}>"
    subject "Reserva de Veículo - Protocolo n. #{requisicao.id}"
    sent_on Time.now # hora de envio do email
    # objetos que serão passados para o helper do template
    body :requisicao => requisicao, :solicitante => solicitante, :configuracoes => Configuracao.all.first
    content_type "text/html"
    template "email_confirmacao" # informa qual template será utilizado
  end

  def email_cancelamento_professor(requisicao)
    solicitante = Solicitante.find(requisicao.solicitante_id)

    recipients configuracoes.email
    from "Astran <#{configuracoes.email}>"
    subject "Cancelamento da Reserva de Veículo - Protocolo n. #{requisicao.id}"
    sent_on Time.now # hora de envio do email
    body :requisicao => requisicao # objetos que serão passados para o helper do template
    content_type "text/html"
    template "email_cancelamento_professor" # informa qual template será utilizado
  end

end

