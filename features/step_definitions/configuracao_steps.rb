Dado /^que eu tenho uma configuração inicial$/ do
  @configuracao = Factory.create :configuracao
end

Dado /^que o formulário de requisição está fora do ar$/ do
  @configuracao.update_attribute(:formulario_ativo, false)
end

Dado /^que a data inicial de proibição seja daqui a (\d+) dias$/ do |dias|
  @configuracao.update_attribute(:data_inicial, (Date.today + dias.to_i.days))
end

Dado /^que a data final de proibição seja daqui a (\d+) dias$/ do |dias|
  @configuracao.update_attribute(:data_final, (Date.today + dias.to_i.days))
end

Então /^eu devo ver a mensagem de proibição$/ do
  str = "Excepcionalmente entre as datas #{@configuracao.data_inicial.to_s_br} \
e #{@configuracao.data_final.to_s_br} não aceitaremos requisição."
  response.should contain(str)
end

