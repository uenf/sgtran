module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
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
      viagem_path(:id => @viagem_id)

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

    when /^página de usuário$/
      new_usuario_path

    when /^página de adição de categoria de veículo$/
      new_categoria_de_veiculo_path

    when /^página de adição de combustível$/
      new_combustivel_path

    # Add more mappings here.
    # Here is a more fancy example:
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

