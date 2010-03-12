Dado /^que eu tenho um prédio com nome "([^\"]*)"$/ do |nome|
  Factory.create :predio, :nome => nome
end

