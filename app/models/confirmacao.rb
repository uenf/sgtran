class Confirmacao < ActionMailer::Base
  
  EMAIL_ASTRAN = "eduardohertz@gmail.com"
  
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
      "http://localhost:3000"
    end
  end


  def enviar_email(corpo_do_email, destinatarios, requisicao)
    #********** falta setar aqui o email correto que ailton deseja receber os avisos **********
    solicitante = Solicitante.find(requisicao.solicitante_id)
    destinatarios = destinatarios.split(";") if destinatarios
    
    recipients solicitante.email
    cc EMAIL_ASTRAN
    bcc destinatarios if destinatarios
    from "Astran <#{EMAIL_ASTRAN}>"
    subject "Reserva de Veículo - Protocolo n. #{requisicao.id}"
    sent_on Time.now # hora de envio do email
    body :requisicao => requisicao, :corpo_do_email => corpo_do_email # objetos que serão passados para o helper do template
    content_type "text/html"
    template "email_padrao" # informa qual template será utilizado
  end  
  
  def enviar_email_aceitar(corpo_do_email, destinatarios, requisicao)
    #********** falta setar aqui o email correto que ailton deseja receber os avisos **********
    solicitante = Solicitante.find(requisicao.solicitante_id)
    destinatarios = destinatarios.split(";") if destinatarios
    
    recipients solicitante.email
    cc EMAIL_ASTRAN
    bcc destinatarios if destinatarios
    from "Astran <#{EMAIL_ASTRAN}>"
    subject "Reserva de Veículo - Protocolo n. #{requisicao.id}"
    sent_on Time.now # hora de envio do email
    body :requisicao => requisicao, :corpo_do_email => corpo_do_email # objetos que serão passados para o helper do template
    content_type "text/html"
    template "email_padrao_aceitar" # informa qual template será utilizado
  end   
  
  def email_confirmacao_de_cadastro_de_requisicao(requisicao)
    requisicao.each do |r|
      solicitante = Solicitante.find(r.solicitante_id)
      
      recipients solicitante.email
      cc EMAIL_ASTRAN
      from "Astran <#{EMAIL_ASTRAN}>"
      subject "Reserva de Veículo - Protocolo n. #{r.id}"
      sent_on Time.now # hora de envio do email
      body :requisicao => r, :solicitante => solicitante # objetos que serão passados para o helper do template
      content_type "text/html"
      template "email_confirmacao" # informa qual template será utilizado      
    end
    
  end
  
  def email_cancelamento_professor(requisicao)
    solicitante = Solicitante.find(requisicao.solicitante_id)
    
    recipients EMAIL_ASTRAN
    from "Astran <#{EMAIL_ASTRAN}>"
    subject "Cancelamento da Reserva de Veículo - Protocolo n. #{requisicao.id}"
    sent_on Time.now # hora de envio do email
    body :requisicao => requisicao # objetos que serão passados para o helper do template
    content_type "text/html"
    template "email_cancelamento_professor" # informa qual template será utilizado    
  end

end

