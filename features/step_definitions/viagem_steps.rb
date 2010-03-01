require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require "factory_girl"

When /^eu escolho a viagem existente$/ do
  field = "id_da_viagem_" + "#{@viagem.id}"
  choose(field)
end

When /^eu não escolho nenhuma viagem$/ do
end

Dado /^que eu tenho uma viagem com o estado "([^\"]*)"$/ do |estado|
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  predio = Factory.create :predio
  solicitante = Factory.create :solicitante, :predio_id => predio.id
  motivo = Factory.create :motivo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva
  motorista = Factory.create :motorista

  case estado
    when Viagem::AGUARDANDO
      @viagem = Factory.create :viagem, :estado => Viagem::AGUARDANDO, :motorista_id => motorista.id
    when Viagem::ATENDIDA
      @viagem = Factory.create :viagem, :estado => Viagem::ATENDIDA, :motorista_id => motorista.id
    when Viagem::CANCELADA
      @viagem = Factory.create :viagem, :estado => Viagem::CANCELADA, :motorista_id => motorista.id
    else
      @viagem = Factory.create :viagem, :motorista_id => motorista.id
  end

  @requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                          :predio_id => predio.id,
                                          :solicitante_id => solicitante.id,
                                          :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                          :viagem_id => @viagem.id

end

