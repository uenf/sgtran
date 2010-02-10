require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Viagem do
  before(:each) do
    @valid_attributes = {

    }
  end

  it "should create a new instance given valid attributes" do
    Viagem.create!(@valid_attributes)
  end

  it "Deve retornar uma lista de requisições atendidas" do
    viagem = Factory.create :viagem
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    requisicao1 = Factory.create :requisicao,
                                 :viagem_id => viagem.id,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id
    requisicao2 = Factory.create :requisicao,
                                 :viagem_id => viagem.id,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id
    viagem.requisicoes_atendidas.should have_exactly(2).items
    viagem.requisicoes_atendidas.should include(requisicao1.id,requisicao2.id)
  end

  describe "associações" do
    should_have_many :requisicoes
    should_belong_to :motorista
  end

end

