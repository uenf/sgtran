Dado /^que eu tenha um veículo da categoria "([^\"]*)", modelo "([^\"]*)" e placa "([^\"]*)"$/ do |categoria, modelo, placa|
  prefixo = Factory.create :prefixo
  categoria_de_veiculo = Factory.create :categoria_de_veiculo, :nome => categoria
  combustivel = Factory.create :combustivel
  @veiculo = Factory.create :veiculo,
                  :categoria_de_veiculo_id => categoria_de_veiculo.id,
                  :modelo => modelo,
                  :placa => placa,
                  :combustivel_ids => [combustivel.id],
                  :prefixo_id => prefixo.id
end

Dado /^que o veículo esteja "([^\"]*)"$/ do |estado|
  @veiculo.estado = Veiculo::ATIVO if estado == Veiculo::ATIVO
  @veiculo.estado = Veiculo::INATIVO if estado == Veiculo::INATIVO
  @veiculo.save
end

Dado /^que eu tenha um veículo$/ do
  prefixo = Factory.create :prefixo
  categoria_de_veiculo = Factory.create :categoria_de_veiculo, :nome => categoria
  combustivel = Factory.create :combustivel
  @veiculo = Factory.create :veiculo,
                  :categoria_de_veiculo_id => categoria_de_veiculo.id,
                  :modelo => modelo,
                  :placa => placa,
                  :combustivel_ids => [combustivel.id],
                  :prefixo_id => prefixo.id
end

