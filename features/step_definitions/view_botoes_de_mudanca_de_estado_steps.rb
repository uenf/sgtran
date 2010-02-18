require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require "factory_girl"

Dado /^que eu tenha uma requisição com estado "(.+)"$/ do |estado|
  solicitante = Factory.create :solicitante
  veiculo = Factory.create :categoria_de_veiculo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva

  if estado == Requisicao::CANCELADO_PELO_PROFESSOR
    @requisicao = Factory.create :requisicao,
                                 :solicitante_id => solicitante.id,
                                 :estado => estado,
                                 :motivo_professor => "algum motivo",
                                 :categoria_de_veiculo_id => veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id
  else
    if estado == Requisicao::REJEITADA or estado == Requisicao::CANCELADO_PELO_SISTEMA
      motivo = Factory.create :motivo
      @requisicao = Factory.create :requisicao,
                                   :solicitante_id => solicitante.id,
                                   :estado => estado,
                                   :categoria_de_veiculo_id => veiculo.id,
                                   :motivo_id => motivo.id,
                                   :objetivo_de_reserva_id => objetivo_de_reserva.id

    else
      @requisicao = Factory.create :requisicao,
                                   :solicitante_id => solicitante.id,
                                   :estado => estado,
                                   :categoria_de_veiculo_id => veiculo.id,
                                   :objetivo_de_reserva_id => objetivo_de_reserva.id
    end
  end
end

