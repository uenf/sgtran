Dado /^que eu tenho um prefixo$/ do
  @prefixo = Factory.create :prefixo
end

Dado /^que eu tenho o prefixo "([^"]*)"$/ do |nome|
  @prefixo = Factory.create :prefixo, :nome => nome
end

Dado /^que o prefixo esteja "([^"]*)"$/ do |status|
  @prefixo.update_attribute(:status, status)
end

Então /^eu devo ter um prefixo "([^"]*)"$/ do |status|
  Prefixo.all.first.status.should == status
end

Então /^eu não devo ter um prefixo$/ do
  Prefixo.all.should have(0).prefixos
end

