require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Usuario do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome",
      :email => "email@email.com",
      :login => "value for login",
      :password => "value for password",
      :password_confirmation => "value for password"
    }
  end

  it "should create a new instance given valid attributes" do
    Usuario.create!(@valid_attributes)
  end

  it "Deve retornar erro quando o login for inválido" do
    usuario = Factory.build :usuario, :login => ""
    usuario.save.should be_false
  end

  it "Deve retornar erro quando a senha não for preenchida" do
    usuario = Factory.build :usuario, :password => ""
    usuario.save.should be_false
  end

  it "Deve retornar erro caso o e-mail seja vazio" do
    usuario = Factory.build :usuario, :email => ""
    usuario.save.should be_false
  end

  it "Deve retornar erro caso o e-mail não esteja no formato correto" do
    usuario = Factory.build :usuario, :email => "teste"
    usuario.save.should be_false
  end

  it "Deve retornar erro caso o nome esteja vazio" do
    usuario = Factory.build :usuario, :nome => ""
    usuario.save.should be_false
  end
end

