require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require "factory_girl"

When /^eu escolho a viagem existente$/ do
  field = "id_da_viagem_" + "#{@viagem.id}"
  choose(field)
end

When /^eu não escolho nenhuma viagem$/ do
end

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
  @viagem = Factory.create :viagem, :estado => estado, :motorista_id => motorista.id
  @viagem.requisicoes << @requisicao_viagem
end

Dado /^que a requisição esteja ligada à viagem$/ do
  @viagem.requisicoes = [] # Gamba para limpar as requisições da viagem criada no passo "que eu tenho outra viagem com o estado"
  @requisicao.viagem_id = @viagem.id
  @requisicao.save
end

