Dado /^que eu tenho um motorista com nome "([^\"]*)"$/ do |nome|
  @motorista = Factory.create :motorista, :nome => nome
end

Dado /^que o motorista esteja "([^\"]*)"$/ do |estado|
  @motorista.estado = Solicitante::INATIVO if estado == "Inativo"
  @motorista.estado = Solicitante::ATIVO if estado == "Ativo"
  @motorista.save
end

Dado /^que sua carteira irá vencer em "([^\"]*)" dias$/ do |n|
  @motorista.vencimento_habilitacao = Date.today + 30.days
  @motorista.save
end

Dado /^que ele não está avisado sobre o vencimento deu sua cnh$/ do
  @motorista.avisado = false
  @motorista.save
end

