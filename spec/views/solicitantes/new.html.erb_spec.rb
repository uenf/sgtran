require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/solicitantes/new.html.erb" do
  include SolicitantesHelper

  before(:each) do
    assigns[:solicitante] = stub_model(Solicitante,
      :new_record? => true,
      :nome => "value for nome",
      :email => "value for email",
      :matricula => "value for matricula"
    )
  end

  it "renders new solicitante form" do
    render

    response.should have_tag("form[action=?][method=post]", solicitantes_path) do
      with_tag("input#solicitante_nome[name=?]", "solicitante[nome]")
      with_tag("input#solicitante_email[name=?]", "solicitante[email]")
      with_tag("input#solicitante_matricula[name=?]", "solicitante[matricula]")
    end
  end
end
