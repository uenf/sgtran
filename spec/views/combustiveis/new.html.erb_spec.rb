require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/combustiveis/new.html.erb" do
  include CombustiveisHelper

  before(:each) do
    assigns[:combustivel] = stub_model(Combustivel,
      :new_record? => true,
      :nome => "value for nome"
    )
  end

  it "renders new combustivel form" do
    render

    response.should have_tag("form[action=?][method=post]", combustiveis_path) do
      with_tag("input#combustivel_nome[name=?]", "combustivel[nome]")
    end
  end
end
