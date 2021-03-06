require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsuarioSession do
  before(:each) do
    @valid_attributes = {
      :login => "sgtran",
      :password => "teste"
    }
  end

  it "should create a new instance given valid attributes" do
    Factory.create :usuario
    activate_authlogic()
    UsuarioSession.create!(@valid_attributes)
  end
end

