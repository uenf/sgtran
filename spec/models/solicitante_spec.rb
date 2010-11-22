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
    Solicitante.delete_all
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

  it "Deve invalidar caso o nome seja vazio" do
    centro = Factory.create :centro
    solicitante = Factory.build :solicitante,
                                :nome => "",
                                :centro_id => centro.id
    solicitante.valid?.should be_false
  end

  it "Deve normalizar a matrícula" do
    matricula = "210"
    Solicitante.normalizar_matricula(matricula).should == "00210"
    matricula = "10210"
    Solicitante.normalizar_matricula(matricula).should == "10210"
    matricula = "100210"
    Solicitante.normalizar_matricula(matricula).should == "100210"
  end

  it "deve verificar se um solicitante existe e está ativo" do
    centro = Factory.create :centro

    Factory.create :solicitante,
                     :centro_id => centro.id,
                     :matricula => "1234",
                     :email => "professor@uenf.br"

    solicitante = Factory.build :solicitante,
                                 :matricula => "1234",
                                 :email => "professor@uenf.br"
    Solicitante.existe_e_esta_ativo?(solicitante).should be_true

    Factory.create :solicitante,
                     :centro_id => centro.id,
                     :matricula => "12345",
                     :email => "professor@uenf.br",
                     :status => Solicitante::INATIVO


    solicitante = Factory.build :solicitante,
                                  :matricula => "12345",
                                  :email => "professor@uenf.br"
    Solicitante.existe_e_esta_ativo?(solicitante).should be_false

    solicitante = Factory.build :solicitante, :centro_id => centro.id, :matricula => "1234",
                                  :email => "professor@uenf.com.br"
    Solicitante.existe_e_esta_ativo?(solicitante).should be_false

  end
end

