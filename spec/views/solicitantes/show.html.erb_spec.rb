require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/solicitantes/show.html.erb" do
  include SolicitantesHelper
  before(:each) do
    assigns[:solicitante] = @solicitante = stub_model(Solicitante,
      :nome => "value for nome",
      :email => "value for email",
      :matricula => "value for matricula"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ nome/)
    response.should have_text(/value\ for\ email/)
    response.should have_text(/value\ for\ matricula/)
  end
end
