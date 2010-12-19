Dado /^que eu tenho uma configuração inicial$/ do
  @configuracao = Factory.create :configuracao
end

Dado /^que o formulário de requisição está fora do ar$/ do
  @configuracao.update_attribute(:formulario_ativo, false)
end

Dado /^que a data inicial de proibição seja daqui a (\d+) dias$/ do |dias|
  @configuracao.update_attribute(:data_inicial_proibicao, (Date.today + dias.to_i.days))
end

Dado /^que a data final de proibição seja daqui a (\d+) dias$/ do |dias|
  @configuracao.update_attribute(:data_final_proibicao, (Date.today + dias.to_i.days))
end

Dado /^que é possível requisitar veículo (.+) ano$/ do |opcao|
  if opcao == 'este'
    @configuracao.update_attribute(:ano_corrente, true)
  elsif opcao == 'em qualquer'
    @configuracao.update_attribute(:ano_corrente, false)
  end
end

Dado /^que o termo deve conter "([^"]*)"$/ do |conteudo|
  @configuracao.update_attribute(:conteudo_termo, conteudo)
end

Então /^eu devo ver a mensagem de proibição$/ do
  str = "Excepcionalmente entre as datas #{@configuracao.data_inicial_proibicao.to_s_br} \
e #{@configuracao.data_final_proibicao.to_s_br} não aceitaremos requisição."
  response.should contain(str)
end

Então /^todos os campos Centro devem estar como Setor$/ do
  visit base_de_dados_path
  response.should contain('Setor')
  response.should_not contain('Centro')

  visit centros_path
  response.should contain('Adicionar Setor')
  response.should_not contain('Adicionar Centro')

  visit new_solicitante_path
  response.should contain('Setor:')
  response.should_not contain('Centro:')
  response.should contain('Selecione um Setor')

  solicitante = Factory.create :solicitante
  visit solicitante_path(solicitante)
  response.should contain('Setor:')
  response.should_not contain('Centro:')

  visit new_centro_path
  response.should contain('Novo setor')
  response.should_not contain('Novo centro')

  centro = Factory.create :centro
  visit edit_centro_path(centro)
  response.should contain('Editar setor')
  response.should_not contain('Editar centro')

  visit centro_path(centro)
  response.should contain('Dados do setor')
  response.should_not contain('Dados do centro')
end

