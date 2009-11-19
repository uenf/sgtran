require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/combustiveis/index.html.erb" do
  include CombustiveisHelper

  before(:each) do
    assigns[:combustiveis] = [
      stub_model(Combustivel,
        :nome => "value for nome"
      ),
      stub_model(Combustivel,
        :nome => "value for nome"
      )
    ]
  end

  it "renders a list of combustiveis" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
  end
end
