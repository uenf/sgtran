require 'spec_helper'

describe Configuracao do
  before(:each) do
    @valid_attributes = {
      :orgao_utilizador => "value for orgao_utilizador"
    }
  end

  it "should create a new instance given valid attributes" do
    Configuracao.create!(@valid_attributes)
  end
end
