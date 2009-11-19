require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/solicitantes/edit.html.erb" do
  include SolicitantesHelper

  before(:each) do
    assigns[:solicitante] = @solicitante = stub_model(Solicitante,
      :new_record? => false,
      :nome => "value for nome",
      :email => "value for email",
      :matricula => "value for matricula"
    )
  end

  it "renders the edit solicitante form" do
    render

    response.should have_tag("form[action=#{solicitante_path(@solicitante)}][method=post]") do
      with_tag('input#solicitante_nome[name=?]', "solicitante[nome]")
      with_tag('input#solicitante_email[name=?]', "solicitante[email]")
      with_tag('input#solicitante_matricula[name=?]', "solicitante[matricula]")
    end
  end
end
