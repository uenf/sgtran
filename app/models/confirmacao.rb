class Confirmacao < ActionMailer::Base

  def email_informando_astran_sobre_cancelamento(requisicao)
    #********** falta setar aqui o email correto que ailton deseja receber os avisos **********
    recipients "email_de_ailton@uenf.br"
    from "Astran <emailtesteuenf@gmail.com>"
    subject "Informação de cancelamento pelo professor"
    sent_on Time.now # hora de envio do email
    body :requisicao => requisicao # objetos que serão passados para o helper do template
    template "informacao_sobre_cancelamento_para_ailton" # informa qual template será utilizado
  end

  def email_com_confirmacao_de_cadastro_de_requisicao(requisicao, solicitante)
    # irá utilizar o email digitado no cadastro do usuário, onde será enviar o mail de confirmação
    recipients solicitante.email
    from "Astran <emailtesteuenf@gmail.com>"
    subject "Reserva de veículo nº " + requisicao.id
    sent_on Time.now
    body :requisicao => requisicao, :solicitante => solicitante
    template "confirmacao_de_cadastro_de_requisicao"
  end

  def email_aceitando_requisicao_caso_1(requisicao, solicitante)
    recipients solicitante.email
    from "Astran <emailtesteuenf@gmail.com>"
    subject "Confirmação da Reserva de veículo nº " + requisicao.id
    sent_on Time.now
    body :requisicao => requisicao, :solicitante => solicitante
    template "requisicao_aceita_caso_1"
  end

  def email_aceitando_requisicao_caso_2(requisicao, solicitante)
    recipients solicitante.email
    from "Astran <emailtesteuenf@gmail.com>"
    subject "Confirmação da Reserva de veículo nº " + requisicao.id
    sent_on Time.now
    body :requisicao => requisicao, :solicitante => solicitante
    template "requisicao_aceita_caso_2"
  end

  #favor ver se a data que está aqui é a mesma da requisição, ou outra
  def email_aceitando_requisicao_caso_3(requisicao, solicitante, destino, data)
    recipients solicitante.email
    from "Astran <emailtesteuenf@gmail.com>"
    subject "Confirmação da Reserva de veículo nº " + requisicao.id
    sent_on Time.now
    #Esse meio de aceitação necessita passar para o corpo da mensagem mais 2 parametros, destino e data (a ver na view deste metodo)
    body :requisicao => requisicao, :solicitante => solicitante, :destino => destino, :data => data
    template "requisicao_aceita_caso_3"
  end

  def email_rejeitando_requisicao_caso_1(requisicao, solicitante)
    recipients solicitante.email
    from "Astran <emailtesteuenf@gmail.com>"
    subject "Impossibilidade da Reserva de veículo nº " + requisicao.id
    sent_on Time.now
    body :requisicao => requisicao, :solicitante => solicitante
    template "requisicao_rejeitada_caso_3"
  end

  def email_rejeitando_requisicao_caso_3(requisicao, solicitante, numero_de_reserva_conflitante)
    recipients solicitante.email
    from "Astran <emailtesteuenf@gmail.com>"
    subject "Impossibilidade da Reserva de veículo nº " + requisicao.id
    sent_on Time.now
    body :requisicao => requisicao, :solicitante => solicitante, :numero_de_reserva_conflitante => numero_de_reserva_conflitante
    template "requisicao_rejeitada_caso_3"
  end

  def email_customizado(destino, assunto, corpo)
    recipients destino
    from "Astran <emailtesteuenf@gmail.com>"
    subject assunto
    sent_on Time.now

    part "text/plain" do |p|
      p.body = corpo
    end

  end

end

