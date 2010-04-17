require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Solicitante do
  before(:each) do
    centro = Factory.create :centro
    @valid_attributes = {
      :nome => "value for nome",
      :email => "fulano@uenf.br",
      :matricula => "value for matricula",
      :cargo => "Professor",
      :centro_id => centro.id
    }
  end

  it "should create a new instance given valid attributes" do
    Solicitante.create!(@valid_attributes)
  end

  it "Deve invalidar e-mail em formato errado." do
    centro = Factory.create :centro
    solicitante = Factory.build :solicitante,
                                :centro_id => centro.id,
                                :email => "professor@uenf"
    solicitante.save.should be_false
  end

  it "Deve estar cheio no caso do professor existir" do
    centro = Factory.create :centro
    Factory.create :solicitante,
                    :email => "professor@uenf.br",
                    :matricula => "01210",
                    :centro_id => centro.id
    solicitante = Solicitante.verificarExistencia({:matricula => "01210",
                                                    :email => "professor@uenf.br",
                                                    :cargo => "Professor"})
    solicitante.should_not be_nil
  end

  it "Deve estar vazio no caso do professor não existir" do
    centro = Factory.create :centro
    Factory.create :solicitante,
                    :email => "professor@uenf.br",
                    :matricula => "01210",
                    :centro_id => centro.id
    solicitante = Solicitante.verificarExistencia({:matricula => "0121001",
                                                    :email => "professor@uenf.br"})
    solicitante.should be_nil
  end

  it "Deve invalidar caso o nome seja vazio" do
    centro = Factory.create :centro
    solicitante = Factory.build :solicitante,
                                :nome => "",
                                :centro_id => centro.id
    solicitante.valid?.should be_false
  end

  it "deve verificar se um solicitante existe" do
    centro = Factory.create :centro
    solicitante = Factory.create :solicitante, :centro_id => centro.id
    dados = {:email => solicitante.email, :matricula => solicitante.matricula}
    Solicitante.verificar_solicitante(dados).should be_true
  end

  it "Deve normalizar a matrícula" do
    matricula = "210"
    Solicitante.normalizar_matricula(matricula).should == "00210"
    matricula = "10210"
    Solicitante.normalizar_matricula(matricula).should == "10210"
    matricula = "100210"
    Solicitante.normalizar_matricula(matricula).should == "100210"
  end
end

