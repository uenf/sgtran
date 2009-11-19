require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categoria_de_veiculos/show.html.erb" do
  include CategoriaDeVeiculosHelper
  before(:each) do
    assigns[:categoria_de_veiculo] = @categoria_de_veiculo = stub_model(CategoriaDeVeiculo,
      :nome => "value for nome"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ nome/)
  end
end
