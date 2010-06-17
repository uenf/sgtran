require 'spec_helper'

describe Prefixo do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome"
    }
  end

  it "should create a new instance given valid attributes" do
    Prefixo.create!(@valid_attributes)
  end

  it "deve ter nome para ser criado" do
    prefixo = Factory.build :prefixo, :nome => nil
    prefixo.save.should be false

    prefixo.nome = "Locado"
    prefixo.save.should be_true
  end
end

