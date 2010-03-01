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

  it "Deve retornar uma lista de requisições atendidas" do
    viagem = Factory.create :viagem
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    requisicao1 = Factory.create :requisicao,
                                 :viagem_id => viagem.id,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id
    requisicao2 = Factory.create :requisicao,
                                 :viagem_id => viagem.id,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id
    viagem.requisicoes_atendidas.should have_exactly(2).items
    viagem.requisicoes_atendidas.should include(requisicao1.id,requisicao2.id)
  end

  it "Deve cancelar uma viagem com várias requisições" do
    viagem = Factory.create :viagem

    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    predio = Factory.create :predio
    solicitante = Factory.create :solicitante, :predio_id => predio.id
    motivo = Factory.create :motivo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva

    requisicao_1 = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                               :solicitante_id => solicitante.id,
                                               :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                               :estado => Requisicao::ACEITA,
                                               :viagem_id => viagem.id


    requisicao_2 = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                               :solicitante_id => solicitante.id,
                                               :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                               :estado => Requisicao::ACEITA,
                                               :viagem_id => viagem.id

    viagem.cancelar_viagem motivo.id
    viagem.estado.should == Viagem::CANCELADA

    requisicao_1 = Requisicao.find(requisicao_1)
    requisicao_2 = Requisicao.find(requisicao_2)

    requisicao_1.estado.should == Requisicao::ESPERA
    requisicao_1.viagem_id.should == nil

    requisicao_2.estado.should == Requisicao::ESPERA
    requisicao_2.viagem_id.should == nil

  end

  describe "associações" do
    should_have_many :requisicoes
    should_belong_to :motorista
  end

end

