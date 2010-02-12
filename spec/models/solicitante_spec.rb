require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Solicitante do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome",
      :email => "fulano@uenf.br",
      :matricula => "value for matricula",
      :cargo_ou_funcao => "Professor"
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

  it "Deve invalidar caso o nome seja vazio" do
    solicitante = Factory.build :solicitante, :nome => ""
    solicitante.valid?.should be_false
  end

  it "deve retornar o número de prédios" do
    Solicitante.predios.should have(17).predios
  end

  it "deve retornar o número de andares" do
    Solicitante.andar.should have(4).andar
  end

  it "deve invalidar caso o prédio seja inválido" do
    solicitante = Factory.build :solicitante, :predio => "Selecione um Prédio"
    solicitante.valid?.should be_false
  end

  it "deve verificar se um solicitante existe" do
    solicitante = Factory.create :solicitante
    dados = {:email => solicitante.email, :matricula => solicitante.matricula}
    Solicitante.verificar_solicitante(dados).should be_true
  end
end

