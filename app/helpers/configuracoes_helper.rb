module ConfiguracoesHelper

  def mostrar_formulario path
    options = {}
    if path == "/configuracoes/formulario"
      return "formulario_requisicao"
    elsif path == "/configuracoes/instituicao"
      return "formulario_instituicao"
    end
  end

end

