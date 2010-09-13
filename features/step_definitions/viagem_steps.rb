require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require "factory_girl"

Dado /^que eu tenho outra viagem com o estado "([^\"]*)"$/ do |estado|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  motorista = Factory.create :motorista
  solicitante = Factory.create :solicitante
  objetivo_de_reserva = Factory.create :objetivo_de_reserva
  @requisicao_viagem = Factory.create :requisicao, # Gamba: Posto esse nome para não sobrescrever a requisicão criada no passo "que eu tenho uma requisição com estado"
                               :solicitante_id => solicitante.id,
                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                               :objetivo_de_reserva_id => objetivo_de_reserva.id
  viagem = Factory.create :viagem,
                          :estado => estado,
                          :motorista_id => motorista.id
  viagem.requisicoes << @requisicao_viagem
end

Dado /^que eu tenho uma viagem com o estado "([^\"]*)"$/ do |estado|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  centro = Factory.create :centro
  solicitante = Factory.create :solicitante, :centro_id => centro.id
  objetivo_de_reserva = Factory.create :objetivo_de_reserva
  @requisicao_viagem = Factory.create :requisicao, # Gamba: Posto esse nome para não sobrescrever a requisicão criada no passo "que eu tenho uma requisição com estado"
                               :solicitante_id => solicitante.id,
                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                               :objetivo_de_reserva_id => objetivo_de_reserva.id
  motivo = Factory.create :motivo
  motorista = Factory.create :motorista
  @viagem = Factory.create :viagem, :estado => estado, :motorista_ids => [motorista.id]
  @viagem.requisicoes << @requisicao_viagem
end

Dado /^que a requisição esteja ligada à viagem$/ do
  @viagem.requisicoes = [] # Gamba para limpar as requisições da viagem criada no passo "que eu tenho outra viagem com o estado"
  @requisicao.viagem_id = @viagem.id
  if @requisicao.data_de_reserva <= Date.today + 2.days
    @requisicao.save_with_validation false
  else
    @requisicao.save
  end
end

Dado /^que eu tenha uma viagem$/ do
  prefixo = Factory.create :prefixo
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva
  combustivel = Factory.create :combustivel
  veiculo = Factory.create :veiculo,
                  :categoria_de_veiculo_id => categoria_de_veiculo.id,
                  :combustivel_ids => [combustivel.id],
                  :prefixo_id => prefixo.id
  motorista = Factory.create :motorista
  requisicao = Factory.create :requisicao,
                              :categoria_de_veiculo_id => categoria_de_veiculo.id,
                              :objetivo_de_reserva_id => objetivo_de_reserva.id
  @viagem = Factory.create :viagem,
                           :motorista_id => motorista.id,
                           :veiculo_id => veiculo.id,
                           :data_partida => requisicao.data_de_reserva,
                           :data_chegada => requisicao.data_de_reserva + 3.days
  requisicao.viagem_id = @viagem.id
  @viagem_id = @viagem.id
end

Dado /^que eu tenho uma viagem em "([^\"]*)" com data de partida "([^\"]*)"$/ do |estado, data|
  data = /\d/.match(data).to_s.to_i
  data = (Date.today + data.days)
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  combustivel = Factory.create :combustivel
  prefixo = Factory.create :prefixo
  veiculo = Factory.create :veiculo,
                  :categoria_de_veiculo_id => categoria_de_veiculo.id,
                  :combustivel_ids => [combustivel.id],
                  :prefixo_id => prefixo.id
  motorista = Factory.create :motorista
  @viagem = Factory.create :viagem,
                           :motorista_id => motorista.id,
                           :veiculo_id => veiculo.id,
                           :data_partida => data,
                           :data_chegada => data + 1.days,
                           :estado => estado
end

Dado /^que eu tenho uma viagem em "([^\"]*)" com data de chegada "([^\"]*)"$/ do |estado, data|
  data = /\d/.match(data).to_s.to_i
  data = (Date.today + data.days)
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  combustivel = Factory.create :combustivel
  prefixo = Factory.create :prefixo
  veiculo = Factory.create :veiculo,
                  :categoria_de_veiculo_id => categoria_de_veiculo.id,
                  :combustivel_ids => [combustivel.id],
                  :prefixo_id => prefixo.id
  motorista = Factory.create :motorista
  @viagem = Factory.create :viagem,
                           :motorista_id => motorista.id,
                           :veiculo_id => veiculo.id,
                           :data_partida => data,
                           :data_chegada => data,
                           :estado => estado
end

Dado /^que eu tenho uma viagem em "([^"]*)" com o motorista "([^"]*)"$/ do |estado, nome_do_motorista|
  prefixo = Factory.create :prefixo
  motorista = Factory.create :motorista, :nome => nome_do_motorista
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  combustivel = Factory.create :combustivel
  veiculo = Factory.create :veiculo,
                  :categoria_de_veiculo_id => categoria_de_veiculo.id,
                  :combustivel_ids => [combustivel.id],
                  :prefixo_id => prefixo.id
  @viagem = Factory.create :viagem,
                           :motorista_id => motorista.id,
                           :veiculo_id => veiculo.id,
                           :data_partida => Date.today,
                           :data_chegada => Date.today,
                           :estado => estado
end

Dado /^que eu tenho uma viagem com esse veículo$/ do
  motorista = Factory.create :motorista
  @viagem = Factory.create :viagem,
                           :motorista_id => motorista.id,
                           :veiculo_id => @veiculo.id,
                           :data_partida => Date.today,
                           :data_chegada => Date.today
end


Quando /^eu escolho a viagem existente$/ do
  field = "id_da_viagem_" + "#{@viagem.id}"
  choose(field)
end

Quando /^eu escolho uma viagem existente diferente da requisição$/ do
  viagens = Viagem.all.collect(&:id)
  field = "id_da_viagem_" + "#{viagens.first}"
  choose(field)
end

Quando /^eu não escolho nenhuma viagem$/ do

end

Quando /^eu preencho a data de "([^\"]*)" com "([^\"]*)"$/ do |field, data|
  if data =~ /Daqui/
    data = /\d/.match(data).to_s.to_i
    data = (Date.today + data.days).strftime("%d/%m/%Y")
  end
  fill_in(field, :with => data)
end

Entao /^eu devo ter uma nova viagem$/ do
  motorista = Factory.create :motorista
  viagem = Factory.create :viagem, :motorista_id => motorista.id
  Requisicao.update(@requisicao.id, :viagem_id => viagem.id)
  @requisicao.viagem = viagem
  @viagem_id = viagem.id + 1
end

Entao /^eu devo ver a data de "([^\"]*)"$/ do |data|
  data = /\d/.match(data).to_s.to_i
  data = (Date.today + data.days).strftime("%d/%m/%Y")
  if defined?(Spec::Rails::Matchers)
    response.should contain(data)
  else
    assert_contain data
  end
end

Então /^eu não devo ver a data de "([^\"]*)"$/ do |data|
  data = /\d/.match(data).to_s.to_i
  data = (Date.today + data.days).strftime("%d/%m/%Y")
  if defined?(Spec::Rails::Matchers)
    response.should_not contain(data)
  else
    assert_contain data
  end
end

Então /^a viagem deve estar cancelada$/ do
  @viagem.reload
  @viagem.estado.should == Viagem::CANCELADA
end

Então /^a viagem deve estar atendida$/ do
  @viagem.reload
  @viagem.estado.should == Viagem::ATENDIDA
end


Então /^a viagem não deve ter nenhuma requisição$/ do
  Requisicao.find_all_by_viagem_id(@viagem.id).should be_empty
end

Então /^a viagem deve ter uma requisição$/ do
  Requisicao.find_all_by_viagem_id(@viagem.id).should_not be_empty
end

Entao /^a viagem não deve atender essa requisição$/ do
  Requisicao.find_all_by_viagem_id(@viagem.id).should_not include @requisicao
end

Então /^eu devo ter (\d+) viagem cancelada$/ do |quantidade|
  Viagem.find_all_by_estado(Viagem::CANCELADA).should have(quantidade.to_i).viagens
end

Então /^eu devo ter (\d+) viagens$/ do |quantidade|
  Viagem.all.should have(quantidade.to_i).viagens
end

