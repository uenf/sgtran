Dado /^que eu tenho um motorista com nome "([^\"]*)"$/ do |nome|
  @motorista = Factory.create :motorista, :nome => nome
end

Dado /^que o motorista esteja "([^\"]*)"$/ do |estado|
  @motorista.estado = Solicitante::INATIVO if estado == "Inativo"
  @motorista.estado = Solicitante::ATIVO if estado == "Ativo"
  @motorista.save
end


