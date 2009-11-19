require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Combustivel do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome"
    }
  end

  it "should create a new instance given valid attributes" do
    Combustivel.create!(@valid_attributes)
  end
end
