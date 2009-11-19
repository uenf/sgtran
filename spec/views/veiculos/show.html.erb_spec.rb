#require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

#describe "/veiculos/show.html.erb" do
#  include VeiculosHelper
#  before(:each) do
#    assigns[:veiculo] = @veiculo = stub_model(Veiculo,
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

#  it "renders attributes in <p>" do
#    render
#    response.should have_text(/value\ for\ marca/)
#    response.should have_text(/value\ for\ modelo/)
#    response.should have_text(/value\ for\ cor/)
#    response.should have_text(/value\ for\ ano/)
#    response.should have_text(/value\ for\ placa/)
#    response.should have_text(/value\ for\ numero_de_ordem/)
#    response.should have_text(/value\ for\ renavam/)
#    response.should have_text(/1/)
#  end
#end

