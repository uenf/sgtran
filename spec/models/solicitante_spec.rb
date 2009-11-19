require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Solicitante do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome",
      :email => "fulano@uenf.br",
      :matricula => "value for matricula",
      :cargo => "Professor"
    }
  end

  it "should create a new instance given valid attributes" do
    Solicitante.create!(@valid_attributes)
  end

  it "Deve invalidar e-mail em formato errado." do
    solicitante = Factory.build :solicitante, :email => "professor@uenf"
    solicitante.save.should be_false
  end

  it "Deve estar cheio no caso do professor existir" do
      Factory.create :solicitante, :email => "professor@uenf.br", :matricula => "01210"
      solicitante = Solicitante.verificarExistencia({:matricula => "01210", :email => "professor@uenf.br", :cargo => "Professor"})
      solicitante.should_not be_nil
  end

  it "Deve estar vazio no caso do professor não existir" do
      Factory.create :solicitante, :email => "professor@uenf.br", :matricula => "01210"
      solicitante = Solicitante.verificarExistencia({:matricula => "0121001", :email => "professor@uenf.br"})
      solicitante.should be_nil
  end
end

