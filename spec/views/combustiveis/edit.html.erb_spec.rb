require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/combustiveis/edit.html.erb" do
  include CombustiveisHelper

  before(:each) do
    assigns[:combustivel] = @combustivel = stub_model(Combustivel,
      :new_record? => false,
      :nome => "value for nome"
    )
  end

  it "renders the edit combustivel form" do
    render

    response.should have_tag("form[action=#{combustivel_path(@combustivel)}][method=post]") do
      with_tag('input#combustivel_nome[name=?]', "combustivel[nome]")
    end
  end
end
