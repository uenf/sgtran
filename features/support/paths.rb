module NavigationHelpers

  def path_to(page_name)
    case page_name

    when /^página de requisição$/
      new_requisicao_path

    when /^página de visualização de requisições$/
      requisicoes_path

    when /^página de detalhes da requisição$/
      requisicao_path(@requisicao)

    when /^página de aceitar requisição$/
      aceitar_path(@requisicao)

    when /^página de confirmação de requisição$/
      confirmar_requisicao_path

    when /^página de cancelamento de requisição$/
      cancelar_requisicao_path(:id => @requisicao.id, :chave_de_seguranca => @requisicao.chave_de_seguranca)

    when /^página de cancelamento pelo sistema da requisição$/
      cancelar_requisicao_pelo_sistema_path(@requisicao)

    when /^página da lista de requisições$/
      requisicoes_path

    when /página de filtragem de requisições/
      filtrar_requisicao_path

    when /página de rejeitar uma requisição/
      rejeitar_path(@requisicao)

    when /^página de visualização de viagens$/
      viagens_path

    when /^página de visualização da viagem$/
      viagem_path(@viagem)

    when /página de filtragem de viagens/
      filtrar_viagem_path

    when /^página de adição de veículo$/
      new_veiculo_path

    when /^página de login$/
      admin_path

    when /^página de visualização de solicitantes$/
      solicitantes_path

    when /^página de visualização de motoristas$/
      motoristas_path

    when /^página de visualização de usuarios$/
      usuarios_path

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

    when /^página de adição de objetivo de reserva$/
      new_objetivo_de_reserva_path

    when /^página de edição do objetivo de reserva$/
      edit_objetivo_de_reserva_path(:id => @objetivo_de_reserva)

    when /^página de adição de motivo$/
      new_motivo_path

    when /^página de edição de motivo$/
      edit_motivo_path(:id => @motivo)

    when /^página de adição de motorista$/
      new_motorista_path

    when /^página de edição de motorista$/
      edit_motorista_path(:id => @motorista)

    when /^página de visualização do motorista$/
      motorista_path(@motorista)

    when /^página de ativação do motorista$/
      ativar_motorista_path(@motorista)

    when /^página de desativação do motorista$/
      desativar_motorista_path(@motorista)

    when /^página de motoristas com CNH para vencer$/
      vencimento_cnh_path

    when /^página de adição de solicitante$/
      new_solicitante_path

    when /^página de edição de solicitante$/
      edit_solicitante_path(:id => @solicitante)

    when /^página de visualização do solicitante$/
      solicitante_path(@solicitante)

    when /^página de aceitar a requisição$/
      aceitar_path(:id => @requisicao)

    when /^página de adição de prédio$/
      new_centro_path

    when /^página de edição de prédio$/
      edit_centro_path(:id => @centro)

    when /^página de edição do prédio$/
      edit_centro_path(@centro)

    when /^página de cancelamento da viagem$/
      cancelar_viagem_path(:id => @viagem)

    when /^página de edição de viagem$/
      edit_viagem_path(:id => @viagem)

    when /^página de visualização do solicitante$/
      solicitante_path(@solicitante)

    when /^página de desativação do solicitante$/
      desativar_solicitante_path(@solicitante)

    when /^página de ativação do solicitante$/
      ativar_solicitante_path(@solicitante)

    when /^página de edição do solicitante$/
      edit_solicitante_path(@solicitante)

    when /^página de edição do veículo$/
      edit_veiculo_path(@veiculo)

    when /^página de edição do categoria de veículo$/
      edit_categoria_de_veiculo_path(@categoria_de_veiculo)

    when /^página de edição do motivo$/
      edit_motivo_path(@motivo)

    when /^página de criação do BDT$/
      fechar_viagem_path(@viagem)

    when /^página de adição de prefixo$/
      new_prefixo_path

    when /^página de edição do prefixo$/
      edit_prefixo_path(@prefixo)

    when /^página de visualização do BDT$/
      bdt_path(@bdt)

    when /^página de edição do BDT$/
      edit_bdt_path(@bdt)

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)

