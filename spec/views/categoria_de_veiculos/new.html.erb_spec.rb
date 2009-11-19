require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categoria_de_veiculos/new.html.erb" do
  include CategoriaDeVeiculosHelper

  before(:each) do
    assigns[:categoria_de_veiculo] = stub_model(CategoriaDeVeiculo,
      :new_record? => true,
      :nome => "value for nome"
    )
  end

  it "renders new categoria_de_veiculo form" do
    render

    response.should have_tag("form[action=?][method=post]", categoria_de_veiculos_path) do
      with_tag("input#categoria_de_veiculo_nome[name=?]", "categoria_de_veiculo[nome]")
    end
  end
end
