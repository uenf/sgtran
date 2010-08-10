require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Motorista do
  before(:each) do
    @valid_attributes = {
      :matricula => "12",
      :nome => "Motorista 01",
      :telefone => "12345678"
    }
    Motorista.delete_all
  end

  should_validate_presence_of :matricula,
                              :nome,
                              :telefone

  it "should create a new instance given valid attributes" do
    Motorista.create!(@valid_attributes)
  end

  it "deve verificar que sua carteira irá vencer em 30 dias" do
    motorista = Factory.create :motorista,
                               :vencimento_habilitacao => Date.today + 30.days
    (Motorista.vence_cnh_em 3.days).should include(motorista.id)

    motorista.update_attribute(:vencimento_habilitacao, nil)
    (Motorista.vence_cnh_em 3.days).should_not include(motorista.id)
  end

  it "ao qual a carteira irá vencer em 30 dias deve ter seu atributo avisado setado para verdadeiro" do
    motorista = Factory.create :motorista,
                               :vencimento_habilitacao => Date.today + 30.days
    motorista.avisar_vencimento_cnh
    motorista.reload
    motorista.avisado.should be_true
  end

  it "deve verificar os motoristas que devem ter o nome no aviso de cnh para vencer" do
    motorista = Factory.create :motorista,
                               :vencimento_habilitacao => Date.today + 30.days,
                               :avisado => false
    (Motorista.para_aviso_cnh).should include(motorista.id)

    motorista.update_attribute(:avisado, true)

    (Motorista.para_aviso_cnh).should_not include(motorista.id)
    (Motorista.para_aviso_cnh).should be_empty
  end

  it "deve responder se está ativou ou não" do
    motorista = Factory.create :motorista
    (motorista.ativo?).should be_true
  end

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

    it "Deve avaliar apenas viagens com estado aguardando" do
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      viagem2 = Factory.create :viagem,
                               :motorista_id => @motorista_zeca.id,
                               :data_partida => data_partida,
                               :data_chegada => data_chegada,
                               :estado => Viagem::ATENDIDA
      motoristas_ocupados = Motorista.ocupados_entre(data_partida, data_chegada)
      motoristas_ocupados.should_not include([@motorista_zeca.nome, @motorista_zeca.id])
      motoristas_ocupados.should have(1).item
    end

    it "Cada motorista deve aparecer apenas uma vez na lista de ocupados" do
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      viagem2 = Factory.create :viagem,
                               :motorista_id => @motorista_joao.id,
                               :data_partida => data_partida,
                               :data_chegada => data_chegada
      motoristas_ocupados = Motorista.ocupados_entre(data_partida, data_chegada)

      motoristas_desejados = motoristas_ocupados.uniq
      motoristas_ocupados.should == motoristas_desejados
    end

    it "Cada motorista deve aparecer apenas uma vez na lista de desocupados" do
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      viagem2 = Factory.create :viagem,
                               :motorista_id => @motorista_joao.id,
                               :data_partida => data_partida,
                               :data_chegada => data_chegada
      motoristas_desocupados = Motorista.desocupados_entre(data_partida + 4.days, data_chegada + 4.days)

      motoristas_desejados = motoristas_desocupados.uniq
      motoristas_desocupados.should == motoristas_desejados
    end

    it "deve aparecer na lista de ocupados ou na de desocupados. Nunca nas duas." do
      motoristas_desocupados = Motorista.desocupados_entre(Date.today, Date.today + 2.days)
      motoristas_ocupados = Motorista.ocupados_entre(Date.today, Date.today + 2.days)

      motoristas_ocupados.should include([@motorista_joao.nome, @motorista_joao.id])
      motoristas_ocupados.should_not include([@motorista_zeca.nome, @motorista_zeca.id])
      motoristas_ocupados.should_not include([@motorista_marco.nome, @motorista_marco.id])

      motoristas_desocupados.should_not include([@motorista_joao.nome, @motorista_joao.id])
      motoristas_desocupados.should include([@motorista_zeca.nome, @motorista_zeca.id])
      motoristas_desocupados.should include([@motorista_marco.nome, @motorista_marco.id])
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

    it "inativos não devem aparecer na lista de motoristas ocupados" do
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      @motorista_joao.update_attribute(:status, "Inativo")
      motoristas_ocupados = Motorista.ocupados_entre(data_partida, data_chegada)
      motoristas_ocupados.should_not include [@motorista_joao.nome, @motorista_joao.id]
    end

    it "inativos não devem aparecer na lista de motoristas desocupados" do
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      @motorista_zeca.update_attribute(:status, "Inativo")
      motoristas_desocupados = Motorista.desocupados_entre(data_partida, data_chegada)
      motoristas_desocupados.should_not include [@motorista_zeca.nome, @motorista_zeca.id]
    end
  end
end

