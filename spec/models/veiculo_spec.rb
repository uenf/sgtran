require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Veiculo do

  it "Deve criar uma nova instancia com valores válidos" do
    combustivel = Factory(:combustivel)
    categoria = Factory(:categoria_de_veiculo)
    veiculo = Factory.create :veiculo,
                             :categoria_de_veiculo_id => categoria.id,
                             :combustivel_ids => [combustivel.id]
    veiculo.save!.should be_true
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
      veiculo = Factory.build :veiculo, :categoria_de_veiculo_id => nil
      veiculo.save.should be_false
      veiculo.errors.invalid?(:categoria_de_veiculo).should be_true
    end

    it "O veículo deve ter no mínimo um combustível" do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      veiculo = Factory.build :veiculo,
                              :categoria_de_veiculo_id => categoria_de_veiculo.id,
                              :combustivel_ids => nil
      veiculo.save.should be_false
      veiculo.errors.invalid?(:combustiveis).should be_true
    end
  end

  describe "ocupados e desocupados mostrando o marcador apenas nos veículos de
            mesma categoria escolhida na requisição" do
    before(:each) do
      @categoria_de_veiculo_1 = Factory.create :categoria_de_veiculo
      @categoria_de_veiculo_2 = Factory.create :categoria_de_veiculo
      combustivel = Factory.create :combustivel
      objetivo_de_reserva = Factory.create :objetivo_de_reserva
      requisicao = Factory.create :requisicao,
                                  :categoria_de_veiculo_id => @categoria_de_veiculo_1.id,
                                  :objetivo_de_reserva_id => objetivo_de_reserva.id
      @veiculo_1 = Factory.create :veiculo,
                                  :categoria_de_veiculo_id => @categoria_de_veiculo_1.id,
                                  :combustivel_ids => [combustivel.id]
      @veiculo_2 = Factory.create :veiculo,
                                  :categoria_de_veiculo_id => @categoria_de_veiculo_2.id,
                                  :combustivel_ids => [combustivel.id]
      @veiculo_3 = Factory.create :veiculo,
                                  :categoria_de_veiculo_id => @categoria_de_veiculo_1.id,
                                  :combustivel_ids => [combustivel.id]
      viagem = Factory.create :viagem,
                              :veiculo_id => @veiculo_1.id,
                              :data_partida => Date.new(2010,03,10),
                              :data_chegada => Date.new(2010,03,12)
    end

    it "Deve fornecer a lista com os dados de veiculos ocupados em um determinado
        intervalo de dias" do
      data_partida = Date.new(2010,03,10)
      data_chegada = Date.new(2010,03,12)
      veiculos_ocupados = Veiculo.ocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)
      veiculos_ocupados.should include ["* " + @veiculo_1.modelo + " - " + @veiculo_1.placa + " - " + @categoria_de_veiculo_1.nome,
                                        @veiculo_1.id]
      veiculos_ocupados.length.should be_equal 1
    end

    it "Deve fornecer a lista com os dados de veiculos ocupados em uma data entre
        as datas de chegada e partida de uma viagem existente" do
      data_partida = Date.new(2010,03,11)
      data_chegada = Date.new(2010,03,11)
      veiculos_ocupados = Veiculo.ocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)
      veiculos_ocupados.should include ["* " + @veiculo_1.modelo + " - " + @veiculo_1.placa + " - " + @categoria_de_veiculo_1.nome,
                                        @veiculo_1.id]
      veiculos_ocupados.length.should be_equal 1
    end

    it "Deve fornecer uma lista sem nenhum veiculo ocupado quando na data não
        existe nenhuma viagem" do
      data_partida = Date.new(2010,03,03)
      data_chegada = Date.new(2010,03,05)
      veiculos_ocupados = Veiculo.ocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)
      veiculos_ocupados.length.should be_equal 0
    end

    it "Deve fornecer a lista com os dados de veiculos desocupados em um
        determinado intervalo de dias" do
      data_partida = Date.new(2010,03,10)
      data_chegada = Date.new(2010,03,12)
      veiculos_desocupados = Veiculo.desocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)
      veiculos_desocupados.should include [@veiculo_2.modelo + " - " + @veiculo_2.placa + " - " + @categoria_de_veiculo_2.nome,
                                            @veiculo_2.id]
      veiculos_desocupados.should include ["* " + @veiculo_3.modelo + " - " + @veiculo_3.placa + " - " + @categoria_de_veiculo_1.nome,
                                            @veiculo_3.id]
      veiculos_desocupados.length.should be_equal 2
    end

    it "Deve fornecer a lista com os dados de veiculos desocupados em uma data
        entre as datas de chegada e partida de uma viagem existente" do
      data_partida = Date.new(2010,03,11)
      data_chegada = Date.new(2010,03,11)
      veiculos_desocupados = Veiculo.desocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)
      veiculos_desocupados.should include [@veiculo_2.modelo + " - " + @veiculo_2.placa + " - " + @categoria_de_veiculo_2.nome,
                                            @veiculo_2.id]
      veiculos_desocupados.should include ["* " + @veiculo_3.modelo + " - " + @veiculo_3.placa + " - " + @categoria_de_veiculo_1.nome,
                                            @veiculo_3.id]
      veiculos_desocupados.length.should be_equal 2
    end

    it "Deve fornecer uma lista com os dados de todos os veiculos como desocupados
        quando na data não existe nenhuma viagem" do
      data_partida = Date.new(2010,03,03)
      data_chegada = Date.new(2010,03,05)
      veiculos_desocupados = Veiculo.desocupados_entre_datas_e_com_categoria(data_partida, data_chegada, @categoria_de_veiculo_1.id)
      veiculos_desocupados.should include ["* " + @veiculo_1.modelo + " - " + @veiculo_1.placa + " - " + @categoria_de_veiculo_1.nome,
                                            @veiculo_1.id]
      veiculos_desocupados.should include [@veiculo_2.modelo + " - " + @veiculo_2.placa + " - " + @categoria_de_veiculo_2.nome,
                                            @veiculo_2.id]
      veiculos_desocupados.should include ["* " + @veiculo_3.modelo + " - " + @veiculo_3.placa + " - " + @categoria_de_veiculo_1.nome,
                                            @veiculo_3.id]
      veiculos_desocupados.length.should be_equal 3
    end
  end
end

