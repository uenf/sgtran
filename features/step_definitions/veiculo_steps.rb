Dado /^que eu tenho o combustivel "([^\"]*)"$/ do |nome|
  Factory.create :combustivel, :nome => nome
end

Dado /^que eu tenho a categoria de veiculo "([^\"]*)"$/ do |nome|
  Factory.create :categoria_de_veiculo, :nome => nome
end

Dado /^que eu tenha um veículo da categoria "([^\"]*)", modelo "([^\"]*)" e placa "([^\"]*)"$/ do |categoria, modelo, placa|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo, :nome => categoria
  combustivel = Factory.create :combustivel
  @veiculo = Factory.create :veiculo,
                  :categoria_de_veiculo_id => categoria_de_veiculo.id,
                  :modelo => modelo,
                  :placa => placa,
                  :combustivel_ids => [combustivel.id]
end

Dado /^que o veículo esteja "([^\"]*)"$/ do |estado|
  @veiculo.estado = Veiculo::ATIVO if estado == Veiculo::ATIVO
  @veiculo.estado = Veiculo::INATIVO if estado == Veiculo::INATIVO
  @veiculo.save
end

