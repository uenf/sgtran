require 'spec_helper'

describe "/motivos/edit.html.erb" do
  include MotivosHelper

  before(:each) do
    assigns[:motivo] = @motivo = stub_model(Motivo,
      :new_record? => false,
      :descricao => "value for descricao"
    )
  end

  it "renders the edit motivo form" do
    render

    response.should have_tag("form[action=#{motivo_path(@motivo)}][method=post]") do
      with_tag('input#motivo_descricao[name=?]', "motivo[descricao]")
    end
  end
end
