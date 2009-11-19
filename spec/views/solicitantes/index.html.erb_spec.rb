require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/solicitantes/index.html.erb" do
  include SolicitantesHelper

  before(:each) do
    assigns[:solicitantes] = [
      stub_model(Solicitante,
        :nome => "value for nome",
        :email => "value for email",
        :matricula => "value for matricula"
      ),
      stub_model(Solicitante,
        :nome => "value for nome",
        :email => "value for email",
        :matricula => "value for matricula"
      )
    ]
  end

  it "renders a list of solicitantes" do
    render
    response.should have_tag("tr>td", "value for nome".to_s, 2)
    response.should have_tag("tr>td", "value for email".to_s, 2)
    response.should have_tag("tr>td", "value for matricula".to_s, 2)
  end
end
