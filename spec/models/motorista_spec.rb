require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Motorista do
  before(:each) do
    @valid_attributes = {
      :matricula => "12",
      :nome_do_motorista => "Motorista 01",
      :telefone_do_motorista => "12345678"
    }
  end

  should_validate_presence_of :matricula,
                              :nome_do_motorista,
                              :telefone_do_motorista

  it "should create a new instance given valid attributes" do
    Motorista.create!(@valid_attributes)
  end

  it "Deve estar cheio no caso do professor existir" do
      Factory.create :motorista, :matricula => "15"
      motorista = Motorista.verificarExistencia({:matricula => "15"})
      motorista.should_not be_nil
  end

  it "Deve estar vazio no caso do professor não existir" do
      Factory.create :motorista, :matricula => "16"
      motorista = Motorista.verificarExistencia({:matricula => "123456231"})
      motorista.should be_nil
  end
end

