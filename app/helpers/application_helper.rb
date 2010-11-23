# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def mensagem_de_erro (objeto)
    if objeto.nil?
      return nil
    else
      if objeto.errors.empty?
        return nil
      end
    end

    string_return = "<div id=\"error_messages\"> <ul>"

    for erro in objeto.errors.full_messages
      string_return += "<li> " + erro + "</li>"
    end

    return string_return + "</ul> </div>"
  end

  def to_permissao lista
    permissoes = {'admin' => 'Administrador', 'visit' => 'Visitante'}
    lista.each do |l|
      indice = lista.index(l)
      lista[indice] = permissoes[l]
    end
    lista
  end

  def visibilidade obj
    obj ? 'visivel' : 'invisivel'
  end

  def selecao obj
    obj ? 'selected="selected"' : nil
  end

  def td_status objeto
    status = objeto.status.downcase
    "<td class=\"#{status}\"></td>".html_safe
  end

  def td_clickable path, content
    ("<td onclick=\"location.href=\'#{path}\'\" onmouseover=\"this.style.cursor='pointer'\">" +
    content + "</td>").html_safe
  end

end

