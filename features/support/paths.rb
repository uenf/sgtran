module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^página de requisição$/
      new_requisicao_path

    when /^página de visualização de requisições$/
      requisicoes_path

    when /^página de detalhes da requisição$/
      requisicao_path(@requisicao)

    when /^página de editar detalhes da viagem$/
      aceitar_path(@requisicao)

    when /^página de visualização de viagens$/
      viagens_path

    when /^página de confirmação de requisição$/
      confirmar_requisicao_path

    when /^página de cancelamento de requisição$/
      cancelar_requisicao_path(:id => @id, :chave_de_seguranca => @chave_de_seguranca)

    when /^página de adição de veículo$/
      new_veiculo_path

    when /^página da lista de requisições$/
      requisicoes_path

    when /^página de login$/
      admin_path

    when /^página de visualização de solicitantes$/
      solicitantes_path

    when /^página de visualização de motoristas$/
      motoristas_path

    when /^página de visualização de usuarios$/
      usuarios_path

    when /^página de visualização de viagens$/
      viagens_path

    when /^página de visualização da viagem$/
      viagem_path(:id => @viagem)

    when /^página de usuário$/
      new_usuario_path

    when /^página de adição de categoria de veículo$/
      new_categoria_de_veiculo_path

    when /^página de edição de categoria de veículo$/
      edit_categoria_de_veiculo_path(:id => @categoria_de_veiculo)

    when /^página de adição de combustível$/
      new_combustivel_path

    when /^página de edição de combustível$/
      edit_combustivel_path(:id => @combustivel)

    when /página de filtragem de requisições/
      filtrar_requisicao_path

    when /página de filtragem de viagens/
      filtrar_viagem_path

    when /página de rejeitar uma requisição/
      rejeitar_path(:id => @requisicao)

    when /^página de adição de objetivo de reserva$/
      new_objetivo_de_reserva_path

    when /^página de edição de objetivo de reserva$/
      edit_objetivo_de_reserva_path(:id => @objetivo_de_reserva)

    when /^página de adição de motivo$/
      new_motivo_path

    when /^página de edição de motivo$/
      edit_motivo_path(:id => @motivo)

    when /^página de adição de motorista$/
      new_motorista_path

    when /^página de edição de motorista$/
      edit_motorista_path(:id => @motorista)

    when /^página de adição de solicitante$/
      new_solicitante_path

    when /^página de edição de solicitante$/
      edit_solicitante_path(:id => @solicitante)
        
    when /^página de aceitar a requisição$/
      aceitar_path(:id => @requisicao)
      

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)

