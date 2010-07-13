require 'spec_helper'

describe Bdt do

  describe 'validação' do

    it "deve criar uma nova instância com atributos válidos" do
      valid_attributes = {
      :recolhimento => Time.now,
      :partida => Time.now,
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
                    :id => viagem.id}

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
end

