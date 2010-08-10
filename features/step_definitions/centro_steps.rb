Dado /^que eu tenho um prédio$/ do
  @centro = Factory.create :centro
end

Dado /^que eu tenho um prédio com nome "([^\"]*)"$/ do |nome|
  @centro = Factory.create :centro, :nome => nome
end

Dado /^que o prédio esteja "([^\"]*)"$/ do |estado|
  @centro.update_attribute(:status, estado)
end

