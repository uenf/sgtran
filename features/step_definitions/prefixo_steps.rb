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

Então /^eu devo ter um prefixo "([^"]*)"$/ do |estado|
  Prefixo.all.first.estado.should == estado
end

Então /^eu não devo ter um prefixo$/ do
  Prefixo.all.should have(0).prefixos
end

