Dado /^que eu tenha a categoria de veículo "([^\"]*)"$/ do |nome|
  @categoria_de_veiculo = Factory.create :categoria_de_veiculo, :nome => nome
end

Dado /^que a categoria de veículo esteja "([^\"]*)"$/ do |status|
  @categoria_de_veiculo.update_attribute(:status, status)
end

