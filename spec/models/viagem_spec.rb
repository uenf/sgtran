require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Viagem do
  before(:each) do
    @valid_attributes = {

    }
  end

  it "should create a new instance given valid attributes" do
    Viagem.create!(@valid_attributes)
  end

  describe "associações" do
    should_have_many :requisicoes
    should_belong_to :motorista
  end
end

