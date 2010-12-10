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

Então /^eu devo ver a mensagem de proibição$/ do
  str = "Excepcionalmente entre as datas #{@configuracao.data_inicial_proibicao.to_s_br} \
e #{@configuracao.data_final_proibicao.to_s_br} não aceitaremos requisição."
  response.should contain(str)
end

