require 'spec_helper'

describe Bdt do

  it "deve calcular a distancia percorrida" do

  end

  describe 'validação' do

    it "deve criar uma nova instância com atributos válidos" do
      valid_attributes = {
      :data_recolhimento => Date.today,
      :horario_recolhimento => Time.now,
      :data_partida => Date.today,
      :horario_partida => Time.now,
      :odometro_recolhimento => 1,
      :odometro_partida => 1,
      :objetivo => "value for objetivo",
      :numero => 1,
      :local_origem => "value for local_origem",
      :local_destino => "value for local_destino"
      }
      Bdt.create!(valid_attributes)
    end

    it "deve validar a presença do número do bdt físico (papel)" do
      bdt = Factory.build :bdt, :numero => nil
      bdt.save.should be_false
    end

    it "deve validar a presença do valor do odômetro na partida" do
      bdt = Factory.build :bdt, :odometro_partida => nil
      bdt.save.should be_false
    end

    it "deve validar a presença do valor do odômetro no recolhimento" do
      bdt = Factory.build :bdt, :odometro_recolhimento => nil
      bdt.save.should be_false
    end

    it "deve validar que o odômetro de recolhimento é maior do que o de partida" do
      bdt = Factory.build :bdt, :odometro_partida => 15200,
                                :odometro_recolhimento => 16100
      bdt.save.should be_true

      bdt = Factory.build :bdt, :odometro_partida => 16100,
                                :odometro_recolhimento => 15200
      bdt.save.should be_false
    end

    it "deve validar a data da partida" do
      bdt = Factory.build :bdt, :data_partida => ""
      bdt.save.should be_false
    end

    it "deve validar o horário da partida" do
      bdt = Factory.build :bdt, :horario_partida => ""
      bdt.save.should be_false
    end

    it "deve validar a data do recolhimento" do
      bdt = Factory.build :bdt, :data_recolhimento => ""
      bdt.save.should be_false
    end

    it "deve validar o horário do recolhimento" do
      bdt = Factory.build :bdt, :horario_recolhimento => ""
      bdt.save.should be_false
    end

  end

  it "deve salvar o bdt, atualizar a viagem e as requisições" do
    motivo = Factory.create :motivo
    combustivel = Factory :combustivel
    prefixo = Factory.create :prefixo, :id => 7
    motorista = Factory.create :motorista
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    veiculo = Factory.create :veiculo,
                             :categoria_de_veiculo_id => categoria_de_veiculo.id,
                             :combustivel_ids => [combustivel.id],
                             :prefixo_id => prefixo.id
    viagem = Factory.create :viagem, :motorista_id => motorista.id
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    requisicao_1 = Factory.create :requisicao,
                                :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                :viagem_id => viagem.id,
                                :estado => Requisicao::ACEITA
    requisicao_2 = Factory.create :requisicao,
                                :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                :viagem_id => viagem.id,
                                :estado => Requisicao::CANCELADO_PELO_SISTEMA,
                                :motivo_id => motivo.id
    bdt = Factory.build :bdt
    dados_viagem = {:veiculo_id => veiculo.id,
                    :motorista_id => motorista.id,
                    :viagem_id => viagem.id}

    bdt.salvar(dados_viagem).should be_true

    bdt.reload
    bdt.viagem_id.should == viagem.id

    viagem.reload
    viagem.estado.should == Viagem::ATENDIDA
    viagem.motorista_id.should == motorista.id
    viagem.veiculo_id.should == veiculo.id

    requisicao_1.reload
    requisicao_1.estado.should == Requisicao::FINALIZADA

    requisicao_2.reload
    requisicao_2.estado.should == Requisicao::CANCELADO_PELO_SISTEMA
  end

  describe "deve atualizar" do


    it "o BDT" do
      motivo = Factory.create :motivo
      combustivel = Factory :combustivel
      prefixo = Factory.create :prefixo
      motorista_1 = Factory.create :motorista
      motorista_2 = Factory.create :motorista, :nome => "Ronaldo"
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      veiculo_1 = Factory.create :veiculo,
                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                               :combustivel_ids => [combustivel.id],
                               :prefixo_id => prefixo.id
      veiculo_2 = Factory.create :veiculo,
                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                               :combustivel_ids => [combustivel.id],
                               :prefixo_id => prefixo.id,
                               :placa => "LLL-0000"

      viagem = Factory.create :viagem,
                              :motorista_id => motorista_1.id,
                              :veiculo_id => veiculo_1
      bdt = Factory.create :bdt, :odometro_partida => 1200,
                                 :odometro_recolhimento => 1300
      dados_viagem = {:veiculo_id => veiculo_2.id,
                      :motorista_id => motorista_2.id,
                      :viagem_id => viagem.id}
      dados_bdt = {:odometro_recolhimento => 1350}

      bdt.atualizar(dados_bdt, dados_viagem).should be_true
      bdt.reload
      bdt.odometro_recolhimento.should == 1350
    end

    it "a viagem" do
      motivo = Factory.create :motivo
      combustivel = Factory :combustivel
      prefixo = Factory.create :prefixo
      motorista_1 = Factory.create :motorista
      motorista_2 = Factory.create :motorista, :nome => "Ronaldo"
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      veiculo_1 = Factory.create :veiculo,
                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                               :combustivel_ids => [combustivel.id],
                               :prefixo_id => prefixo.id
      veiculo_2 = Factory.create :veiculo,
                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                               :combustivel_ids => [combustivel.id],
                               :prefixo_id => prefixo.id,
                               :placa => "LLL-0000"

      viagem = Factory.create :viagem,
                              :motorista_id => motorista_1.id,
                              :veiculo_id => veiculo_1
      bdt = Factory.create :bdt, :odometro_partida => 1200,
                                 :odometro_recolhimento => 1300
      dados_viagem = {:veiculo_id => veiculo_2.id,
                      :motorista_id => motorista_2.id,
                      :viagem_id => viagem.id}
      dados_bdt = {:odometro_recolhimento => 1350}

      dados_viagem[:viagem_id] = viagem.id
      bdt.atualizar(dados_bdt, dados_viagem).should be_true
      viagem.reload
      viagem.motorista_id.should == motorista_2.id
      viagem.veiculo_id.should == veiculo_2.id
    end

  end

end

