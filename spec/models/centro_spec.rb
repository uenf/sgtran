require 'spec_helper'

describe Centro do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome"
    }
  end

  it "should create a new instance given valid attributes" do
    Centro.create!(@valid_attributes)
  end

  should_validate_presence_of :nome

  it 'deve retornar a quantidade de quilometros percorridos em um intervalo de tempo' do
    motorista = Factory.create :motorista
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva

    centro1 = Factory.create :centro
    centro2 = Factory.create :centro

    solicitante1 = Factory.create :solicitante, :centro_id => centro1.id
    solicitante2 = Factory.create :solicitante, :centro_id => centro2.id

    viagem_maio = Factory.create :viagem, :motoristas => [motorista]
    requisicao_maio1 = Factory.create :requisicao,
                                      :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                      :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                      :solicitante_id => solicitante1.id,
                                      :viagem_id => viagem_maio.id,
                                      :estado => 'Finalizada'

    requisicao_maio2 = Factory.create :requisicao,
                                      :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                      :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                      :solicitante_id => solicitante2.id,
                                      :viagem_id => viagem_maio.id,
                                      :estado => 'Finalizada'

    viagem_junho = Factory.create :viagem, :motoristas => [motorista]
    requisicao_junho = Factory.create :requisicao,
                                      :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                      :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                      :solicitante_id => solicitante1.id,
                                      :viagem_id => viagem_junho.id,
                                      :estado => 'Finalizada'


    viagem_julho = Factory.create :viagem, :motoristas => [motorista]
    requisicao_julho = Factory.create :requisicao,
                                      :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                      :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                      :solicitante_id => solicitante1.id,
                                      :viagem_id => viagem_julho.id,
                                      :estado => 'Aceita'


    bdt_maio = Factory.create :bdt, :data_partida => '19/05/2009',
                              :data_recolhimento => '19/05/2009',
                              :odometro_partida => 12000,
                              :odometro_recolhimento => 12500,
                              :viagem_id => viagem_maio.id

    bdt_junho = Factory.create :bdt, :data_partida => '25/06/2009',
                               :data_recolhimento => '27/06/2009',
                               :odometro_partida => 23000,
                               :odometro_recolhimento => 23874,
                               :viagem_id => viagem_junho.id


    centro1.distancia_percorrida_entre('05/05/2009', '18/05/2009').should == 0
    centro1.distancia_percorrida_entre('18/05/2009', '19/05/2009').should == 500
    centro1.distancia_percorrida_entre('19/05/2009', '19/05/2009').should == 500
    centro1.distancia_percorrida_entre('19/05/2009', '20/05/2009').should == 500
    centro1.distancia_percorrida_entre('23/06/2009', '26/06/2009').should == 0
    centro1.distancia_percorrida_entre('25/06/2009', '27/06/2009').should == 874
    centro2.distancia_percorrida_entre('25/06/2009', '27/06/2009').should == 0
    centro1.distancia_percorrida_entre('10/05/2009', '30/06/2009').should == 1374
    centro1.distancia_percorrida_entre('10/05/2009', '03/07/2009').should == 1374
    centro2.distancia_percorrida_entre('10/05/2009', '03/07/2009').should == 500
    centro2.distancia_percorrida_entre('01/07/2009', '03/07/2009').should == 0
  end
end

