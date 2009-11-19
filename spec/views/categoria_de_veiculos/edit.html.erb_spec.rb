require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categoria_de_veiculos/edit.html.erb" do
  include CategoriaDeVeiculosHelper

  before(:each) do
    assigns[:categoria_de_veiculo] = @categoria_de_veiculo = stub_model(CategoriaDeVeiculo,
      :new_record? => false,
      :nome => "value for nome"
    )
  end

  it "renders the edit categoria_de_veiculo form" do
    render

    response.should have_tag("form[action=#{categoria_de_veiculo_path(@categoria_de_veiculo)}][method=post]") do
      with_tag('input#categoria_de_veiculo_nome[name=?]', "categoria_de_veiculo[nome]")
    end
  end
end
