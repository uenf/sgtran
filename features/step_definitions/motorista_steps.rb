Dado /^que exista um motorista com nome "([^\"]*)"$/ do |nome|
  @motorista = Factory.create :motorista, :nome => nome
end

