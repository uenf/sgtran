require 'spec_helper'

describe "/bdts/index.html.erb" do
  include BdtsHelper

  before(:each) do
    assigns[:bdts] = [
      stub_model(Bdt,
        :odometro_recolhimento => 1,
        :odometro_partida => 1,
        :objetivo => "value for objetivo",
        :numero => 1,
        :local_origem => "value for local_origem",
        :local_destino => "value for local_destino"
      ),
      stub_model(Bdt,
        :odometro_recolhimento => 1,
        :odometro_partida => 1,
        :objetivo => "value for objetivo",
        :numero => 1,
        :local_origem => "value for local_origem",
        :local_destino => "value for local_destino"
      )
    ]
  end

  it "renders a list of bdts" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for objetivo".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for local_origem".to_s, 2)
    response.should have_tag("tr>td", "value for local_destino".to_s, 2)
  end
end
