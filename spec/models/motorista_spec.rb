require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Motorista do
  before(:each) do
    @valid_attributes = {
      :matricula => "12",
      :nome_do_motorista => "Motorista 01",
      :telefone_do_motorista => "12345678"
    }
  end

  should_validate_presence_of :matricula,
                              :nome_do_motorista,
                              :telefone_do_motorista

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
      @motorista_joao = Factory.create :motorista, :nome_do_motorista => "João"
      @motorista_zeca = Factory.create :motorista, :nome_do_motorista => "Zeca"
      @motorista_marco = Factory.create :motorista, :nome_do_motorista => "Marco"
      viagem = Factory.create :viagem,
                              :motorista_id => @motorista_joao.id,
                              :data_partida => Date.new(2010,03,10),
                              :data_chegada => Date.new(2010,03,12)
    end

    it "Deve fornecer a lista com o nome e o id dos motoristas ocupados em um determinado
        intervalo de dias" do
      data_partida = "10/03/2010"
      data_chegada = "12/03/2010"
      motoristas_ocupados = Motorista.ocupados_entre(data_partida, data_chegada)
      motoristas_ocupados.should include [@motorista_joao.nome_do_motorista, @motorista_joao.id]
      motoristas_ocupados.length.should be_equal 1
    end

    it "Deve fornecer a lista com o nome e o id dos motoristas ocupados em uma data
        entre as datas de chegada e partida de uma viagem existente" do
      data_partida = "11/03/2010"
      data_chegada = "11/03/2010"
      motoristas_ocupados = Motorista.ocupados_entre(data_partida, data_chegada)
      motoristas_ocupados.should include [@motorista_joao.nome_do_motorista, @motorista_joao.id]
      motoristas_ocupados.length.should be_equal 1
    end

    it "Deve fornecer uma lista sem nenhum motorista ocupado quando na data não
        existe nenhuma viagem" do
      data_partida = "03/03/2010"
      data_chegada = "05/03/2010"
      motoristas_ocupados = Motorista.ocupados_entre(data_partida, data_chegada)
      motoristas_ocupados.length.should be_equal 0
    end

    it "Deve fornecer a lista com o nome e o id dos motoristas desocupados em um
        determinado intervalo de dias" do
      data_partida = "10/03/2010"
      data_chegada = "12/03/2010"
      motoristas_desocupados = Motorista.desocupados_entre(data_partida, data_chegada)
      motoristas_desocupados.should include [@motorista_zeca.nome_do_motorista, @motorista_zeca.id]
      motoristas_desocupados.should include [@motorista_marco.nome_do_motorista, @motorista_marco.id]
      motoristas_desocupados.length.should be_equal 2
    end

    it "Deve fornecer a lista com o nome e o id dos motoristas desocupados em uma data
        entre as datas de chegada e partida de uma viagem existente" do
      data_partida = "11/03/2010"
      data_chegada = "11/03/2010"
      motoristas_desocupados = Motorista.desocupados_entre(data_partida, data_chegada)
      motoristas_desocupados.should include [@motorista_zeca.nome_do_motorista, @motorista_zeca.id]
      motoristas_desocupados.should include [@motorista_marco.nome_do_motorista, @motorista_marco.id]
      motoristas_desocupados.length.should be_equal 2
    end

    it "Deve fornecer uma lista com o nome e o id todos os motoristas como desocupados
        quando na data não existe nenhuma viagem" do
      data_partida = "03/03/2010"
      data_chegada = "05/03/2010"
      motoristas_desocupados = Motorista.desocupados_entre(data_partida, data_chegada)
      motoristas_desocupados.should include [@motorista_joao.nome_do_motorista, @motorista_joao.id]
      motoristas_desocupados.should include [@motorista_zeca.nome_do_motorista, @motorista_zeca.id]
      motoristas_desocupados.should include [@motorista_marco.nome_do_motorista, @motorista_marco.id]
      motoristas_desocupados.length.should be_equal 3
    end
  end
end

