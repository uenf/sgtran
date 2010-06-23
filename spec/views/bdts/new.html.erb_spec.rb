require 'spec_helper'

describe "/bdts/new.html.erb" do
  include BdtsHelper

  before(:each) do
    assigns[:bdt] = stub_model(Bdt,
      :new_record? => true,
      :odometro_recolhimento => 1,
      :odometro_partida => 1,
      :objetivo => "value for objetivo",
      :numero => 1,
      :local_origem => "value for local_origem",
      :local_destino => "value for local_destino"
    )
  end

  it "renders new bdt form" do
    render

    response.should have_tag("form[action=?][method=post]", bdts_path) do
      with_tag("input#bdt_odometro_recolhimento[name=?]", "bdt[odometro_recolhimento]")
      with_tag("input#bdt_odometro_partida[name=?]", "bdt[odometro_partida]")
      with_tag("input#bdt_objetivo[name=?]", "bdt[objetivo]")
      with_tag("input#bdt_numero[name=?]", "bdt[numero]")
      with_tag("input#bdt_local_origem[name=?]", "bdt[local_origem]")
      with_tag("input#bdt_local_destino[name=?]", "bdt[local_destino]")
    end
  end
end
