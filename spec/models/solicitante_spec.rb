require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Solicitante do
  before(:each) do
    predio = Factory.create :predio
    @valid_attributes = {
      :nome => "value for nome",
      :email => "fulano@uenf.br",
      :matricula => "value for matricula",
      :cargo_ou_funcao => "Professor",
      :predio_id => predio.id
    }
  end

  it "should create a new instance given valid attributes" do
    Solicitante.create!(@valid_attributes)
  end

  it "Deve invalidar e-mail em formato errado." do
    predio = Factory.create :predio
    solicitante = Factory.build :solicitante,
                                :predio_id => predio.id,
                                :email => "professor@uenf"
    solicitante.save.should be_false
  end

  it "Deve estar cheio no caso do professor existir" do
    predio = Factory.create :predio
    Factory.create :solicitante,
                    :email => "professor@uenf.br",
                    :matricula => "01210",
                    :predio_id => predio.id
    solicitante = Solicitante.verificarExistencia({:matricula => "01210",
                                                    :email => "professor@uenf.br",
                                                    :cargo => "Professor"})
    solicitante.should_not be_nil
  end

  it "Deve estar vazio no caso do professor não existir" do
    predio = Factory.create :predio
    Factory.create :solicitante,
                    :email => "professor@uenf.br",
                    :matricula => "01210",
                    :predio_id => predio.id
    solicitante = Solicitante.verificarExistencia({:matricula => "0121001",
                                                    :email => "professor@uenf.br"})
    solicitante.should be_nil
  end

  it "Deve invalidar caso o nome seja vazio" do
    predio = Factory.create :predio
    solicitante = Factory.build :solicitante,
                                :nome => "",
                                :predio_id => predio.id
    solicitante.valid?.should be_false
  end

  it "deve verificar se um solicitante existe" do
    predio = Factory.create :predio
    solicitante = Factory.create :solicitante, :predio_id => predio.id
    dados = {:email => solicitante.email, :matricula => solicitante.matricula}
    Solicitante.verificar_solicitante(dados).should be_true
  end
end

