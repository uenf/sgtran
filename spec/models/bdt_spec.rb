require 'spec_helper'

describe Bdt do
  before(:each) do
    @valid_attributes = {
      :recolhimento => Time.now,
      :partida => Time.now,
      :odometro_recolhimento => 1,
      :odometro_partida => 1,
      :objetivo => "value for objetivo",
      :numero => 1,
      :local_origem => "value for local_origem",
      :local_destino => "value for local_destino"
    }
  end

  it "should create a new instance given valid attributes" do
    Bdt.create!(@valid_attributes)
  end
end
