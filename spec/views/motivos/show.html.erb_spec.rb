require 'spec_helper'

describe "/motivos/show.html.erb" do
  include MotivosHelper
  before(:each) do
    assigns[:motivo] = @motivo = stub_model(Motivo,
      :descricao => "value for descricao"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ descricao/)
  end
end
