require 'spec_helper'

describe "/bdts/show.html.erb" do
  include BdtsHelper
  before(:each) do
    assigns[:bdt] = @bdt = stub_model(Bdt,
      :odometro_recolhimento => 1,
      :odometro_partida => 1,
      :objetivo => "value for objetivo",
      :numero => 1,
      :local_origem => "value for local_origem",
      :local_destino => "value for local_destino"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ objetivo/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ local_origem/)
    response.should have_text(/value\ for\ local_destino/)
  end
end
