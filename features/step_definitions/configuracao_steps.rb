Dado /^que eu tenho uma configuração inicial$/ do
  @configuracao = Factory.create :configuracao
end

Dado /^que o formulário de requisição está fora do ar$/ do
  @configuracao.update_attribute(:formulario_ativo, false)
end

