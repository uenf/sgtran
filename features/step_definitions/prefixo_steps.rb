Dado /^que eu tenho um prefixo$/ do
  @prefixo = Factory.create :prefixo
end

Dado /^que o prefixo esteja "([^"]*)"$/ do |estado|
  @prefixo.estado = estado
end

