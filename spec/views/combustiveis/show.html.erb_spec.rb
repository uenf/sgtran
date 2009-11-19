require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/combustiveis/show.html.erb" do
  include CombustiveisHelper
  before(:each) do
    assigns[:combustivel] = @combustivel = stub_model(Combustivel,
      :nome => "value for nome"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ nome/)
  end
end
