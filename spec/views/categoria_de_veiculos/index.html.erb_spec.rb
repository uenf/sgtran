require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categoria_de_veiculos/index.html.erb" do
  include CategoriaDeVeiculosHelper

  before(:each) do
    assigns[:categoria_de_veiculos] = [
      stub_model(CategoriaDeVeiculo,
        :nome => "value for nome"
      ),
      stub_model(CategoriaDeVeiculo,
        :nome => "value for nome"
      )
    ]
  end

  it "renders a list of categoria_de_veiculos" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
  end
end
