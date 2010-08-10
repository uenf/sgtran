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

Dado /^que o veículo esteja "([^\"]*)"$/ do |status|
  @veiculo.update_attribute(:status, status)
end

Dado /^que eu tenho um veículo de modelo "([^"]*)" e placa "([^"]*)"$/ do |modelo, placa|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  combustivel = Factory.create :combustivel
  prefixo = Factory.create :prefixo, :id => prefixo
  @veiculo = Factory.create :veiculo,
                  :categoria_de_veiculo_id => categoria_de_veiculo.id,
                  :prefixo_id => prefixo.id,
                  :placa => placa,
                  :modelo => modelo,
                  :combustivel_ids => [combustivel.id]
end

Dado /^que este veiculo esteja ligado à viagem$/ do
  @viagem.update_attribute(:veiculo_id, @veiculo.id)
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

