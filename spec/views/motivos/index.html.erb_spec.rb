require 'spec_helper'

describe "/motivos/index.html.erb" do
  include MotivosHelper

  before(:each) do
    assigns[:motivos] = [
      stub_model(Motivo,
        :descricao => "value for descricao"
      ),
      stub_model(Motivo,
        :descricao => "value for descricao"
      )
    ]
  end

  it "renders a list of motivos" do
    render
    response.should have_tag("tr>td", "value for descricao".to_s, 2)
  end
end
