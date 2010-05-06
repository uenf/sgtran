require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

require 'factory_girl'

Given /^que eu tenho uma requisição do solicitante com matricula "(.+)" e com o nome "(.+)"$/ do |matricula, nome|
  centro = Factory.create :centro
  solicitante = Factory.create :solicitante, :matricula => matricula, :nome => nome, :centro_id => centro.id
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva
  @requisicao = Factory.create :requisicao,
                              :solicitante_id => solicitante.id,
                              :categoria_de_veiculo_id => categoria_de_veiculo.id,
                              :objetivo_de_reserva_id => objetivo_de_reserva.id,
                              :data_de_reserva => Date.today + 2.days         

end

Dado /^que eu tenho uma requisição com estado cancelado por motivo de (.+)$/ do |motivo|
  centro = Factory.create :centro
  solicitante = Factory.create :solicitante, :matricula => "10120", :nome => "nome", :centro_id => centro.id  
  categoria_de_veiculo = Factory.create :categoria_de_veiculo
  objetivo_de_reserva = Factory.create :objetivo_de_reserva
  @requisicao = Factory.create :requisicao,
                              :categoria_de_veiculo_id => categoria_de_veiculo.id,
                              :objetivo_de_reserva_id => objetivo_de_reserva.id,
                              :data_de_reserva => Date.today + 2.days,
                              :solicitante_id => solicitante.id      
                                                   
  @requisicao.cancelar_pelo_professor(motivo)
end

Quando /^eu vou para página de cancelamento de requisição com id "([^\"]*)" e chave de segurança "([^\"]*)"$/ do |id, chave_de_seguranca|
  visit cancelar_requisicao_path(:controller => "requisicoes", :action => "cancelar_requisicao", :id => id, :chave_de_seguranca => chave_de_seguranca)
end

