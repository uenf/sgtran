Dado /^que eu tenho um prédio$/ do
  @centro = Factory.create :centro
end

Dado /^que eu tenho um prédio com nome "([^\"]*)"$/ do |nome|
  Factory.create :centro, :nome => nome
end

