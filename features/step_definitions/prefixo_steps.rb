Dado /^que eu tenho um prefixo$/ do
  @prefixo = Factory.create :prefixo
end

Dado /^que eu tenho o prefixo "([^"]*)"$/ do |nome|
  @prefixo = Factory.create :prefixo, :nome => nome
end

Dado /^que o prefixo esteja "([^"]*)"$/ do |estado|
  @prefixo.estado = estado
  @prefixo.save
end

