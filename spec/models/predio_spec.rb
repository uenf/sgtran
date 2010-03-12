require 'spec_helper'

describe Predio do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome"
    }
  end

  it "should create a new instance given valid attributes" do
    Predio.create!(@valid_attributes)
  end

  should_validate_presence_of :nome
end

