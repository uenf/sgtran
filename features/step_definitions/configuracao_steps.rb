Dado /^que eu tenho uma configuração inicial$/ do
  @configuracao = Factory.create :configuracao
end

Dado /^que o formulário de requisição está fora do ar$/ do
  @configuracao.formulario_ativo = false
  @configuracao.save
end

