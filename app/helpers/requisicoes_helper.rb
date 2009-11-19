module RequisicoesHelper

  def traduz_class_css(estado)
    estado.downcase.gsub(" ", "_")
  end

  def requisicao_pode_ser_aceita(estado)
    [Requisicao::ESPERA, Requisicao::REJEITADA, Requisicao::CANCELADO_PELO_SISTEMA].include? estado
  end

  def requisicao_pode_ser_rejeitada(estado)
    [Requisicao::ESPERA].include? estado
  end

  def requisicao_pode_ser_cancelada(estado)
    [Requisicao::ACEITA].include? estado
  end

end

