require 'spec_helper'

describe Motivo do
  before(:each) do
    @valid_attributes = {
      :descricao => "value for descricao"
    }
  end

  it "should create a new instance given valid attributes" do
    Motivo.create!(@valid_attributes)
  end
end
