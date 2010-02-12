require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Viagem do
  before(:each) do
    @valid_attributes = {

    }
  end

  it "should create a new instance given valid attributes" do
    Viagem.create!(@valid_attributes)
  end
  
  it "Deve filtrar as viagens pelas opções definidas" do
    viagem1 = Factory.create :viagem, :estado => Viagem::AGUARDANDO
    viagem2 = Factory.create :viagem, :estado => Viagem::CANCELADA
    viagem3 = Factory.create :viagem, :estado => Viagem::ATENDIDA
    filtro = {:aguardando => "Aguardando",
              :cancelada => "Cancelada",
              :atendida => "Atendida"}
    Viagem.filtrar(filtro[:aguardando]).should == viagem1
    Viagem.filtrar(filtro[:cancelada]).should == viagem2
    Viagem.filtrar(filtro[:atendida]).should == viagem3
    
  end

  describe "associações" do
    should_have_many :requisicoes
    should_belong_to :motorista
  end
end

