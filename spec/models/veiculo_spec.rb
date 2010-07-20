require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Veiculo do

  it "Deve criar uma nova instancia com valores válidos" do
    prefixo = Factory.create :prefixo
    combustivel = Factory :combustivel
    categoria = Factory :categoria_de_veiculo
    veiculo = Factory.create :veiculo,
                             :categoria_de_veiculo_id => categoria.id,
                             :combustivel_ids => [combustivel.id],
                             :prefixo_id => prefixo.id
    veiculo.save!.should be_true
  end

  it "deve responder se está ativou ou não" do
    motorista = Factory.create :motorista, :estado => "Ativo"
    (motorista.ativo?).should be_true
  end

  it "deve fornecer uma lista com os dados dos veículos para o bdt (modelo e placa)" do
    prefixo = Factory.create :prefixo, :id => 7
    combustivel = Factory :combustivel
    categoria = Factory :categoria_de_veiculo
    veiculo = Factory.create :veiculo,
                             :categoria_de_veiculo_id => categoria.id,
                             :combustivel_ids => [combustivel.id],
                             :prefixo_id => prefixo.id,
                             :id => 15,
                             :placa => "LCD-6969",
                             :modelo => "Uno"

    veiculo.formatacao_para_bdt.should include
    "#{veiculo.modelo} - #{veiculo.placa}"
  end

  context "Validações:" do

    should_validate_presence_of :marca,
                                :modelo,
                                :cor,
                                :ano,
                                :placa,
                                :numero_de_ordem,
                                :renavam

    it "O veículo deve ter uma categoria" do
      prefixo = Factory.create :prefixo
      veiculo = Factory.build :veiculo,
                              :categoria_de_veiculo_id => nil,
                              :prefixo_id => prefixo.id
      veiculo.save.should be_false
      veiculo.errors.invalid?(:categoria_de_veiculo).should be_true
    end

    it "O veículo deve ter no mínimo um combustível" do
      prefixo = Factory.create :prefixo
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      veiculo = Factory.build :veiculo,
                              :categoria_de_veiculo_id => categoria_de_veiculo.id,
                              :combustivel_ids => nil,
                              :prefixo_id => prefixo.id
      veiculo.save.should be_false
      veiculo.errors.invalid?(:combustiveis).should be_true
    end

    it "deve ter um prefixo" do
      veiculo = Factory.build :veiculo, :prefixo_id => ""
      veiculo.save.should be_false
    end
  end

  describe "ocupados e desocupados mostrando o marcador apenas nos veículos de
            mesma categoria escolhida na requisição" do

    before(:each) do
      prefixo = Factory.create :prefixo
      motorista = Factory.create :motorista
      @categoria_de_veiculo_1 = Factory.create :categoria_de_veiculo, :nome => "Categoria 1"
      @categoria_de_veiculo_2 = Factory.create :categoria_de_veiculo, :nome => "Categoria 2"
      combustivel = Factory.create :combustivel
      objetivo_de_reserva = Factory.create :objetivo_de_reserva
      requisicao = Factory.create :requisicao,
                                  :categoria_de_veiculo_id => @categoria_de_veiculo_1.id,
                                  :objetivo_de_reserva_id => objetivo_de_reserva.id
      @veiculo_1 = Factory.create :veiculo,
                                  :categoria_de_veiculo_id => @categoria_de_veiculo_1.id,
                                  :combustivel_ids => [combustivel.id],
                                  :prefixo_id => prefixo.id
      @veiculo_2 = Factory.create :veiculo,
                                  :categoria_de_veiculo_id => @categoria_de_veiculo_2.id,
                                  :combustivel_ids => [combustivel.id],
                                  :prefixo_id => prefixo.id
      @veiculo_3 = Factory.create :veiculo,
                                  :categoria_de_veiculo_id => @categoria_de_veiculo_1.id,
                                  :combustivel_ids => [combustivel.id],
                                  :prefixo_id => prefixo.id
      viagem = Factory.create :viagem,
                              :veiculo_id => @veiculo_1.id,
                              :motorista_id => motorista.id,
                              :data_partida => Date.today,
                              :data_chegada => Date.today + 2.days
    end

    it "Deve avaliar apenas viagens com estado aguardando" do
      motorista = Factory.create :motorista
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      viagem2 = Factory.create :viagem,
                               :veiculo_id => @veiculo_2.id,
                               :motorista_id => motorista.id,
                               :data_partida => data_partida,
                               :data_chegada => data_chegada,
                               :estado => Viagem::ATENDIDA
      veiculos_ocupados = Veiculo.ocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_2.id)
      veiculos_ocupados.should_not include ["* " + @veiculo_2.modelo + " - " + @veiculo_2.placa + " - " + @categoria_de_veiculo_2.nome,
                                            @veiculo_2.id]
      veiculos_ocupados.should have(1).item


      combustivel = Factory.create :combustivel
      prefixo = Factory.create :prefixo
      veiculo_4 = Factory.create :veiculo,
                                 :categoria_de_veiculo_id => @categoria_de_veiculo_2.id,
                                 :combustivel_ids => [combustivel.id],
                                 :prefixo_id => prefixo.id
      viagem3 = Factory.create :viagem,
                               :veiculo_id => veiculo_4.id,
                               :motorista_id => motorista.id,
                               :data_partida => data_partida,
                               :data_chegada => data_chegada,
                               :estado => Viagem::ATENDIDA
      veiculos_desocupados = Veiculo.desocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_2.id)
      veiculos_desocupados.should include ["* " + veiculo_4.modelo + " - " + veiculo_4.placa + " - " + @categoria_de_veiculo_2.nome,
                                            veiculo_4.id]
      veiculos_desocupados.should have(3).item
    end

    it "Cada veículo deve aparecer apenas uma vez na lista ocupados" do
      motorista = Factory.create :motorista
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      viagem2 = Factory.create :viagem,
                               :veiculo_id => @veiculo_1.id,
                               :motorista_id => motorista.id,
                               :data_partida => data_partida,
                               :data_chegada => data_chegada
      veiculos_ocupados = Veiculo.ocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)

      veiculos_desejados = veiculos_ocupados.uniq
      veiculos_ocupados.should == veiculos_desejados
    end

    it "Cada veículo deve aparecer apenas uma vez na lista desocupados" do
      motorista = Factory.create :motorista
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      viagem2 = Factory.create :viagem,
                               :veiculo_id => @veiculo_1.id,
                               :motorista_id => motorista.id,
                               :data_partida => data_partida,
                               :data_chegada => data_chegada
      veiculos_desocupados = Veiculo.desocupados_entre_datas_e_com_categoria(data_partida + 4.days, data_chegada + 4.days, @categoria_de_veiculo_1.id)

      veiculos_desejados = veiculos_desocupados.uniq
      veiculos_desocupados.should == veiculos_desejados
    end

    it "deve aparecer na lista de ocupados ou na de desocupados. Nunca nas duas." do
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      veiculos_ocupados = Veiculo.ocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)
      veiculos_desocupados = Veiculo.desocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)

      veiculos_ocupados.should include(["* " + @veiculo_1.modelo + " - " + @veiculo_1.placa + " - " + @categoria_de_veiculo_1.nome,
                                        @veiculo_1.id])
      veiculos_ocupados.should_not include(["* " + @veiculo_3.modelo + " - " + @veiculo_3.placa + " - " + @categoria_de_veiculo_1.nome,
                                        @veiculo_3.id])

      veiculos_desocupados.should_not include(["* " + @veiculo_1.modelo + " - " + @veiculo_1.placa + " - " + @categoria_de_veiculo_1.nome,
                                        @veiculo_1.id])
      veiculos_desocupados.should include(["* " + @veiculo_3.modelo + " - " + @veiculo_3.placa + " - " + @categoria_de_veiculo_1.nome,
                                        @veiculo_3.id])
    end

    it "Deve fornecer a lista com os dados de veiculos ocupados em um determinado
        intervalo de dias" do
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      veiculos_ocupados = Veiculo.ocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)
      veiculos_ocupados.should include ["* " + @veiculo_1.modelo + " - " + @veiculo_1.placa + " - " + @categoria_de_veiculo_1.nome,
                                        @veiculo_1.id]
      veiculos_ocupados.length.should be_equal 1
    end

    it "Deve fornecer a lista com os dados de veiculos ocupados em uma data entre
        as datas de chegada e partida de uma viagem existente" do
      data_partida = Date.tomorrow
      data_chegada = Date.tomorrow
      veiculos_ocupados = Veiculo.ocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)
      veiculos_ocupados.should include ["* " + @veiculo_1.modelo + " - " + @veiculo_1.placa + " - " + @categoria_de_veiculo_1.nome,
                                        @veiculo_1.id]
      veiculos_ocupados.length.should be_equal 1
    end

    it "Deve fornecer uma lista sem nenhum veiculo ocupado quando na data não
        existe nenhuma viagem" do
      data_partida = Date.today + 5.days
      data_chegada = Date.today + 7.days
      veiculos_ocupados = Veiculo.ocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)
      veiculos_ocupados.length.should be_equal 0
    end

    it "Deve fornecer a lista com os dados de veiculos desocupados em um
        determinado intervalo de dias" do
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      veiculos_desocupados = Veiculo.desocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)
      veiculos_desocupados.should include [@veiculo_2.modelo + " - " + @veiculo_2.placa + " - " + @categoria_de_veiculo_2.nome,
                                            @veiculo_2.id]
      veiculos_desocupados.should include ["* " + @veiculo_3.modelo + " - " + @veiculo_3.placa + " - " + @categoria_de_veiculo_1.nome,
                                            @veiculo_3.id]
      veiculos_desocupados.length.should be_equal 2
    end

    it "Deve fornecer a lista com os dados de veiculos desocupados em uma data
        entre as datas de chegada e partida de uma viagem existente" do
      data_partida = Date.tomorrow
      data_chegada = Date.tomorrow
      veiculos_desocupados = Veiculo.desocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)
      veiculos_desocupados.should include [@veiculo_2.modelo + " - " + @veiculo_2.placa + " - " + @categoria_de_veiculo_2.nome,
                                            @veiculo_2.id]
      veiculos_desocupados.should include ["* " + @veiculo_3.modelo + " - " + @veiculo_3.placa + " - " + @categoria_de_veiculo_1.nome,
                                            @veiculo_3.id]
      veiculos_desocupados.length.should be_equal 2
    end

    it "Deve fornecer uma lista com os dados de todos os veiculos como desocupados
        quando na data não existe nenhuma viagem" do
      data_partida = Date.today + 5.days
      data_chegada = Date.today + 7.days
      veiculos_desocupados = Veiculo.desocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)
      veiculos_desocupados.should include ["* " + @veiculo_1.modelo + " - " + @veiculo_1.placa + " - " + @categoria_de_veiculo_1.nome,
                                            @veiculo_1.id]
      veiculos_desocupados.should include [@veiculo_2.modelo + " - " + @veiculo_2.placa + " - " + @categoria_de_veiculo_2.nome,
                                            @veiculo_2.id]
      veiculos_desocupados.should include ["* " + @veiculo_3.modelo + " - " + @veiculo_3.placa + " - " + @categoria_de_veiculo_1.nome,
                                            @veiculo_3.id]
      veiculos_desocupados.length.should be_equal 3
    end

    it "inativos não devem aparecer na lista de veiculos ocupados" do
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      @veiculo_1.estado = "Inativo"
      @veiculo_1.save
      veiculos_ocupados = Veiculo.ocupados_entre_datas_e_com_categoria(data_partida, data_chegada,@categoria_de_veiculo_1)
      veiculos_ocupados.should_not include [@veiculo_1.modelo + " - " + @veiculo_1.placa + " - " + @categoria_de_veiculo_1.nome,
                                            @veiculo_1.id]
    end

    it "inativos não devem aparecer na lista de veiculos desocupados" do
      data_partida = Date.today
      data_chegada = Date.today + 2.days
      @veiculo_2.estado = "Inativo"
      @veiculo_2.save
      veiculos_desocupados = Veiculo.desocupados_entre_datas_e_com_categoria(data_partida, data_chegada,@categoria_de_veiculo_2)
      veiculos_desocupados.should_not include [@veiculo_2.modelo + " - " + @veiculo_2.placa + " - " + @categoria_de_veiculo_2.nome,
                                               @veiculo_2.id]
    end
  end
end

