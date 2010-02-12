require 'spec_helper'

describe "/motivos/new.html.erb" do
  include MotivosHelper

  before(:each) do
    assigns[:motivo] = stub_model(Motivo,
      :new_record? => true,
      :descricao => "value for descricao"
    )
  end

  it "renders new motivo form" do
    render

    response.should have_tag("form[action=?][method=post]", motivos_path) do
      with_tag("input#motivo_descricao[name=?]", "motivo[descricao]")
    end
  end
end
