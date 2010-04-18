require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Motorista do
  before(:each) do
    @valid_attributes = {
      :matricula => "12",
      :nome => "Motorista 01",
      :telefone => "12345678"
    }
  end

  should_validate_presence_of :matricula,
                              :nome,
                              :telefone

  it "should create a new instance given valid attributes" do
    Motorista.create!(@valid_attributes)
  end

# Comentado por não ter a mínima ideia de onde veio isso!!!
################################################################################
#  it "Deve estar cheio no caso do professor existir" do
#    Factory.create :motorista, :matricula => "15"
#    motorista = Motorista.verificarExistencia({:matricula => "15"})
#    motorista.should_not be_nil
#  end

#  it "Deve estar vazio no caso do professor não existir" do
#    Factory.create :motorista, :matricula => "16"
#    motorista = Motorista.verificarExistencia({:matricula => "123456231"})
#    motorista.should be_nil
#  end
################################################################################
  describe "ocupados e desocupados" do
    before(:each) do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      objetivo_de_reserva = Factory.create :objetivo_de_reserva
      requisicao = Factory.create :requisicao,
                                  :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                  :objetivo_de_reserva_id => objetivo_de_reserva.id
      @motorista_joao = Factory.create :motorista, :nome => "João"
      @motorista_zeca = Factory.create :motorista, :nome => "Zeca"
      @motorista_marco = Factory.create :motorista, :nome => "Marco"
      viagem = Factory.create :viagem,
                              :motorista_id => @motorista_joao.id,
                              :data_partida => Date.today,
                              :data_chegada => Date.today + 2.days
    end

    it "Cada motorista deve aparecer apenas uma vez na lista, mesmo que atenda a mais de uma viagem" do
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      viagem2 = Factory.create :viagem,
                               :motorista_id => @motorista_joao.id,
                               :data_partida => data_partida,
                               :data_chegada => data_chegada
      motoristas_ocupados = Motorista.ocupados_entre(data_partida, data_chegada)

      flag = 0
      motoristas_ocupados.each do |item|
        flag += 1 if item.include? @motorista_joao.id
      end
      flag.should == 1
    end

    it "Deve fornecer a lista com o nome e o id dos motoristas ocupados em um determinado
        intervalo de dias" do
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      motoristas_ocupados = Motorista.ocupados_entre(data_partida, data_chegada)
      motoristas_ocupados.should include [@motorista_joao.nome, @motorista_joao.id]
      motoristas_ocupados.length.should be_equal 1
    end

    it "Deve fornecer a lista com o nome e o id dos motoristas ocupados em uma data
        entre as datas de chegada e partida de uma viagem existente" do
      data_partida = Date.tomorrow
      data_chegada = Date.tomorrow
      motoristas_ocupados = Motorista.ocupados_entre(data_partida, data_chegada)
      motoristas_ocupados.should include [@motorista_joao.nome, @motorista_joao.id]
      motoristas_ocupados.length.should be_equal 1
    end

    it "Deve fornecer uma lista sem nenhum motorista ocupado quando na data não
        existe nenhuma viagem" do
      data_partida = Date.today + 5.days
      data_chegada = Date.today + 7.days
      motoristas_ocupados = Motorista.ocupados_entre(data_partida, data_chegada)
      motoristas_ocupados.length.should be_equal 0
    end

    it "Deve fornecer a lista com o nome e o id dos motoristas desocupados em um
        determinado intervalo de dias" do
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      motoristas_desocupados = Motorista.desocupados_entre(data_partida, data_chegada)
      motoristas_desocupados.should include [@motorista_zeca.nome, @motorista_zeca.id]
      motoristas_desocupados.should include [@motorista_marco.nome, @motorista_marco.id]
      motoristas_desocupados.length.should be_equal 2
    end

    it "Deve fornecer a lista com o nome e o id dos motoristas desocupados em uma data
        entre as datas de chegada e partida de uma viagem existente" do
      data_partida = Date.tomorrow
      data_chegada = Date.tomorrow
      motoristas_desocupados = Motorista.desocupados_entre(data_partida, data_chegada)
      motoristas_desocupados.should include [@motorista_zeca.nome, @motorista_zeca.id]
      motoristas_desocupados.should include [@motorista_marco.nome, @motorista_marco.id]
      motoristas_desocupados.length.should be_equal 2
    end

    it "Deve fornecer uma lista com o nome e o id todos os motoristas como desocupados
        quando na data não existe nenhuma viagem" do
      data_partida = Date.today + 5.days
      data_chegada = Date.today + 7.days
      motoristas_desocupados = Motorista.desocupados_entre(data_partida, data_chegada)
      motoristas_desocupados.should include [@motorista_joao.nome, @motorista_joao.id]
      motoristas_desocupados.should include [@motorista_zeca.nome, @motorista_zeca.id]
      motoristas_desocupados.should include [@motorista_marco.nome, @motorista_marco.id]
      motoristas_desocupados.length.should be_equal 3
    end
  end
end

