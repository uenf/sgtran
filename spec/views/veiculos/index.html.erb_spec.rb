#require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

#describe "/veiculos/index.html.erb" do
#  include VeiculosHelper

#  before(:each) do
#    assigns[:veiculos] = [
#      stub_model(Veiculo,
#        :marca => "value for marca",
#        :modelo => "value for modelo",
#        :cor => "value for cor",
#        :ano => "value for ano",
#        :placa => "value for placa",
#        :numero_de_ordem => "value for numero_de_ordem",
#        :renavam => "value for renavam",
#        :categoria_de_veiculo_id => 1
#      ),
#      stub_model(Veiculo,
#        :marca => "value for marca",
#        :modelo => "value for modelo",
#        :cor => "value for cor",
#        :ano => "value for ano",
#        :placa => "value for placa",
#        :numero_de_ordem => "value for numero_de_ordem",
#        :renavam => "value for renavam",
#        :categoria_de_veiculo_id => 1
#      )
#    ]
#  end

#  it "renders a list of veiculos" do
#    render
#    response.should have_tag("tr>td", "value for marca".to_s, 2)
#    response.should have_tag("tr>td", "value for modelo".to_s, 2)
#    response.should have_tag("tr>td", "value for cor".to_s, 2)
#    response.should have_tag("tr>td", "value for ano".to_s, 2)
#    response.should have_tag("tr>td", "value for placa".to_s, 2)
#    response.should have_tag("tr>td", "value for numero_de_ordem".to_s, 2)
#    response.should have_tag("tr>td", "value for renavam".to_s, 2)
#    response.should have_tag("tr>td", 1.to_s, 2)
#  end
#end

