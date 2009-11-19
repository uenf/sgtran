#require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

#describe "/veiculos/new.html.erb" do
#  include VeiculosHelper

#  before(:each) do
#    assigns[:veiculo] = stub_model(Veiculo,
#      :new_record? => true,
#      :marca => "value for marca",
#      :modelo => "value for modelo",
#      :cor => "value for cor",
#      :ano => "value for ano",
#      :placa => "value for placa",
#      :numero_de_ordem => "value for numero_de_ordem",
#      :renavam => "value for renavam",
#      :categoria_de_veiculo_id => 1
#    )
#  end

#  it "renders new veiculo form" do
#    render

#    response.should have_tag("form[action=?][method=post]", veiculos_path) do
#      with_tag("input#veiculo_marca[name=?]", "veiculo[marca]")
#      with_tag("input#veiculo_modelo[name=?]", "veiculo[modelo]")
#      with_tag("input#veiculo_cor[name=?]", "veiculo[cor]")
#      with_tag("input#veiculo_ano[name=?]", "veiculo[ano]")
#      with_tag("input#veiculo_placa[name=?]", "veiculo[placa]")
#      with_tag("input#veiculo_numero_de_ordem[name=?]", "veiculo[numero_de_ordem]")
#      with_tag("input#veiculo_renavam[name=?]", "veiculo[renavam]")
#      with_tag("input#veiculo_categoria_de_veiculo_id[name=?]", "veiculo[categoria_de_veiculo_id]")
#    end
#  end
#end

