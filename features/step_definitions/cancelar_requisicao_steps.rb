require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

require 'factory_girl'

Given /^que eu tenho uma requisição do solicitante com matricula "(.+)" e com o nome "(.+)"$/ do |matricula, nome|
  solicitante = Factory.create :solicitante, :matricula => matricula, :nome => nome
  veiculo = Factory.create :categoria_de_veiculo
  requisicao = Factory.create :requisicao, :solicitante_id => solicitante.id, :categoria_de_veiculo_id => veiculo.id
  @id = requisicao.id
  @chave_de_seguranca = requisicao.chave_de_seguranca
end

Given /^que eu tenho uma requisição com estado cancelado por motivo de (.+)$/ do |motivo|
  requisicao = Factory.create :requisicao
  requisicao.cancelar_pelo_professor(motivo)
  @id = requisicao.id
  @chave_de_seguranca = requisicao.chave_de_seguranca
end

When /^eu vou para página de cancelamento de requisição com id (.+) e chave de segurança (.+)$/ do |id,chave_de_seguranca|
  visit cancelar_requisicao_path(:controller => "requisicoes", :action => "cancelar_requisicao", :id => id, :chave_de_seguranca => chave_de_seguranca)
end

When /^eu vou para página de cancelamento de requisição$/ do
  visit cancelar_requisicao_path(:controller => "requisicoes", :action => "cancelar_requisicao", :id => @id, :chave_de_seguranca => @chave_de_seguranca)
end

