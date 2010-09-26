Dado /^que eu tenho um centro$/ do
  @centro = Factory.create :centro
end

Dado /^que eu tenho um centro com nome "([^\"]*)"$/ do |nome|
  @centro = Factory.create :centro, :nome => nome
end

Dado /^que o centro esteja "([^\"]*)"$/ do |status|
  @centro.update_attribute(:status, status)
end

