require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Viagem do

  before(:each) do
    Factory.create :configuracao
  end

  should_validate_presence_of :motorista_ids

  it "Data de partida não pode ser posterior à data de chegada" do
    data_partida = Date.today + 2.days
    data_chegada = Date.today
    viagem = Factory.build :viagem,
                            :data_partida => data_partida,
                            :data_chegada => data_chegada
    viagem.save.should be_false
  end

  it "Data de partida e de chegada não podem ser anteriores à data atual" do
    data_partida = Date.yesterday - 1.day
    data_chegada = Date.yesterday
    viagem = Factory.build :viagem,
                            :data_partida => data_partida,
                            :data_chegada => data_chegada
    viagem.save.should be_false
  end

  it "Deve filtrar as viagens pelas opções definidas" do
    motorista = Factory.create :motorista
    viagem1 = Factory.create :viagem, :estado => Viagem::AGUARDANDO, :motorista_ids => [motorista.id]
    viagem2 = Factory.create :viagem, :estado => Viagem::CANCELADA, :motorista_ids => [motorista.id]
    viagem3 = Factory.create :viagem, :estado => Viagem::ATENDIDA, :motorista_ids => [motorista.id]
    filtro = {:aguardando => "Aguardando",
              :cancelada => "Cancelada",
              :atendida => "Atendida"}
    Viagem.filtrar(filtro[:aguardando]).should include viagem1
    Viagem.filtrar(filtro[:cancelada]).should include viagem2
    Viagem.filtrar(filtro[:atendida]).should include viagem3

  end

  it "Deve retornar uma lista de requisições atendidas" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
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

  it "Deve retornar uma lista com os nomes dos solicitantes das requisições atendidas pela viagem" do
    motorista = Factory.create :motorista
    solicitante1 = Factory.create :solicitante, :nome => "Renato Abreu"
    solicitante2 = Factory.create :solicitante, :nome => "Geraldo Martins"
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    requisicao1 = Factory.create :requisicao,
                                 :viagem_id => viagem.id,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                 :solicitante_id => solicitante1.id
    requisicao2 = Factory.create :requisicao,
                                 :viagem_id => viagem.id,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                 :solicitante_id => solicitante2.id
    viagem.nomes_solicitantes.should have_exactly(2).items
    viagem.nomes_solicitantes.should include(solicitante1.nome,solicitante2.nome)
  end

  it "Deve retornar uma lista com os nomes dos solicitantes das requisições atendidas pela viagem" do
    motorista = Factory.create :motorista
    solicitante1 = Factory.create :solicitante, :nome => "Renato Abreu"
    solicitante2 = Factory.create :solicitante, :nome => "Renato Abreu"
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    requisicao1 = Factory.create :requisicao,
                                 :viagem_id => viagem.id,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                 :solicitante_id => solicitante1.id
    requisicao2 = Factory.create :requisicao,
                                 :viagem_id => viagem.id,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                 :solicitante_id => solicitante2.id
    viagem.nomes_solicitantes.should have_exactly(1).items
    viagem.nomes_solicitantes.should include(solicitante1.nome)
  end

  it "Deve cancelar uma viagem com várias requisições" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    centro = Factory.create :centro
    solicitante = Factory.create :solicitante, :centro_id => centro.id
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

    requisicao_3 = Factory.build :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                               :solicitante_id => solicitante.id,
                                               :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                               :estado => Requisicao::ACEITA,
                                               :viagem_id => viagem.id,
                                               :data_de_reserva => Date.today - 2.days
    requisicao_3.save_with_validation false
    viagem.cancelar_viagem motivo.id
    viagem.estado.should == Viagem::CANCELADA

    requisicao_1.reload
    requisicao_2.reload
    requisicao_3.reload

    requisicao_1.estado.should == Requisicao::CANCELADO_PELO_SISTEMA
    requisicao_1.viagem_id.should_not == nil

    requisicao_2.estado.should == Requisicao::CANCELADO_PELO_SISTEMA
    requisicao_2.viagem_id.should_not == nil

    requisicao_3.estado.should == Requisicao::CANCELADO_PELO_SISTEMA
    requisicao_3.viagem_id.should_not == nil

  end

  it "Deve verificar se o estado da viagem é Aguardando" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
    viagem.esta_aguardando?.should be_true
  end

  it "Deve verificar se é possível fechar a viagem" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :estado => Viagem::CANCELADA, :motorista_ids => [motorista.id]
    viagem.pode_ser_fechada?.should be_false
    viagem.estado = Viagem::AGUARDANDO
    viagem.pode_ser_fechada?.should be_true
  end

  it "Deve fechar uma viagem" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :estado => Viagem::CANCELADA, :motorista_ids => [motorista.id]
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    centro = Factory.create :centro
    solicitante = Factory.create :solicitante, :centro_id => centro.id
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
    viagem.fechar_viagem.should be_false
    viagem.estado = Viagem::AGUARDANDO
    viagem.fechar_viagem.should be_true
    viagem.estado.should == Viagem::ATENDIDA
    requisicao_1.reload
    requisicao_2.reload
    requisicao_1.estado.should == Requisicao::FINALIZADA
    requisicao_2.estado.should == Requisicao::FINALIZADA
  end

  it "deve apagar a viagem se ela não possui requisição" do
    Viagem.delete_all
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :estado => Viagem::CANCELADA, :motorista_ids => [motorista.id]
    Viagem.verificar_viagem viagem.id
    Viagem.all.should be_empty
  end

  it "deve buscar as viagens pela data de partida" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem,
                            :motorista_ids => [motorista.id],
                            :data_partida => Date.today,
                            :data_chegada => Date.today + 2.days
    data_de_partida = Date.today.strftime("%d/%m/%Y")
    Viagem.buscar_por_data_de_partida(data_de_partida).should include viagem
  end

  it "deve listar todas a viagens quando uma data de chegada inválida for informada" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem,
                            :motorista_ids => [motorista.id],
                            :data_partida => Date.today,
                            :data_chegada => Date.today + 2.days
    data_de_partida = "40/05/2010"

    Viagem.buscar_por_data_de_partida(data_de_partida).should include *Viagem.all
  end

  it "deve buscar as viagens pela data de chegada" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem,
                            :motorista_ids => [motorista.id],
                            :data_partida => Date.today,
                            :data_chegada => Date.today + 2.days
    data_de_chegada = (Date.today + 2.days).strftime("%d/%m/%Y")
    Viagem.buscar_por_data_de_chegada(data_de_chegada).should include viagem
  end

  it "deve listar todas a viagens quando uma data de chegada inválida for informada" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem,
                            :motorista_ids => [motorista.id],
                            :data_partida => Date.today,
                            :data_chegada => Date.today + 2.days
    data_de_chegada = "40/05/2010"

    Viagem.buscar_por_data_de_chegada(data_de_chegada).should include *Viagem.all
  end

  it "deve buscar viagens pelo nome do motorista" do
    motorista_1 = Factory.create :motorista, :nome => "José"
    motorista_2 = Factory.create :motorista, :nome => "João"
    viagem_1 = Factory.create :viagem,
                            :motorista_ids => [motorista_1.id],
                            :data_partida => Date.today,
                            :data_chegada => Date.today
    viagem_2 = Factory.create :viagem,
                            :motorista_ids => [motorista_2.id],
                            :data_partida => Date.today,
                            :data_chegada => Date.today
    motorista = "José"
    Viagem.buscar_por_motorista(motorista).should include(viagem_1)
    Viagem.buscar_por_motorista(motorista).should_not include(viagem_2)
  end

  it "deve buscar viagens pela placa do veículo" do
    prefixo = Factory.create :prefixo
    motorista = Factory.create :motorista
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    combustivel = Factory.create :combustivel
    veiculo_1 = Factory.create :veiculo,
                               :placa => "KKK 6666",
                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                               :combustivel_ids => [combustivel.id],
                               :prefixo_id => prefixo.id
    veiculo_2 = Factory.create :veiculo,
                               :placa => "GGG 6666",
                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                               :combustivel_ids => [combustivel.id],
                               :prefixo_id => prefixo.id
    viagem_1 = Factory.create :viagem,
                              :veiculo_id => veiculo_1.id,
                              :data_partida => Date.today,
                              :data_chegada => Date.today,
                              :motorista_ids => [motorista.id]

    viagem_2 = Factory.create :viagem,
                              :veiculo_id => veiculo_2.id,
                              :data_partida => Date.today,
                              :data_chegada => Date.today,
                              :motorista_ids => [motorista.id]

    placa = "KKK"
    Viagem.buscar_por_placa(placa).should include(viagem_1)
    Viagem.buscar_por_placa(placa).should_not include(viagem_2)
  end

  it "deve verificar se uma viagem pode ser cancelada" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
    viagem.pode_ser_cancelada?.should be_true

    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    centro = Factory.create :centro
    solicitante = Factory.create :solicitante, :centro_id => centro.id
    motivo = Factory.create :motivo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                               :solicitante_id => solicitante.id,
                                               :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                               :estado => Requisicao::ACEITA,
                                               :viagem_id => viagem.id
    viagem.reload.pode_ser_cancelada?.should be_false
  end

#  it "deve cancelar uma viagem que não atende nenhuma requisição" do
#    motorista = Factory.create :motorista
#    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
#    viagem.reload
#    viagem.estado.should == Viagem::CANCELADA
#  end

  describe "associações" do
    should_have_many :requisicoes
    # Comentei por não saber como fazer o testes para essa associação
    # should_belong_to :motorista
  end

end

