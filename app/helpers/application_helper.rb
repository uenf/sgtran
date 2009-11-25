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

end

