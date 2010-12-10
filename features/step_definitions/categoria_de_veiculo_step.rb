Dado /^que eu tenha a categoria de veículo "([^\"]*)"$/ do |nome|
  @categoria_de_veiculo = Factory.create :categoria_de_veiculo, :nome => nome
end

Dado /^que eu tenha a categoria de veículo "([^"]*)" padrão$/ do |nome|
  @categoria_de_veiculo = Factory.create :categoria_de_veiculo, :nome => nome,
                                          :numero_minimo_dias => 0,
                                          :numero_maximo_dias => 0
end


Dado /^que a categoria de veículo esteja "([^\"]*)"$/ do |status|
  @categoria_de_veiculo.update_attribute(:status, status)
end

