require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Requisicao do

  before(:each) do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    @valid_attributes = {
      :solicitante_id => "5",
      :celular => "2020202",
      :data_de_reserva => Date.tomorrow.tomorrow,
      :categoria_de_veiculo_id => categoria_de_veiculo.id,
      :objetivo_da_reserva => "gasvchgsvchjsvdc",
      :outros => "vfdsvdfvfdv",
      :nome_telefone_passageiros => "fhjdsvcdsvghsvd",
      :roteiro_da_agenda => "djvsdghvsvdsv",
      :observacao => "bfdbfdbdfbfdbd",
      :chave_de_seguranca => "a6170a5d995e53fe01f9b02f60e3bbc1c2bfcc74",
      :estado => Requisicao::ESPERA,
      :motivo_id => nil,
      :motivo_professor => "",
      :tipo => nil,
      :referencia_id => nil,
      :viagem_id => "12"
    }
  end

  it "Deve criar uma nova instancia com valores válidos" do
    Requisicao.create!(@valid_attributes)
  end


  it "deve aceitar uma requisição" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    requisicao = Factory.create :requisicao,
                                :categoria_de_veiculo_id => categoria_de_veiculo.id
    requisicao.aceitar(mock_model(Motorista),
                       mock_model(Veiculo),
                       Date.tomorrow.tomorrow,
                       Date.tomorrow.tomorrow,
                       "10:00")

    requisicao.estado.should == Requisicao::ACEITA
  end

  context "Validações:" do

      should_validate_presence_of :data_de_reserva,
                                  :nome_telefone_passageiros,
                                  :roteiro_da_agenda

    it "O campo Categoria de veículo deve ser selecionado" do
      requisicao = Factory.build :requisicao, :categoria_de_veiculo_id => ""
      requisicao.save.should be_false
      requisicao.errors.invalid?(:categoria_de_veiculo).should be_true
    end

    it "O campo Objetivo da reserva deve ser diferente de Selecione um Objetivo" do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      requisicao = Factory.build :requisicao,
                                 :objetivo_da_reserva => "Selecione um Objetivo",
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id
      requisicao.save.should be_false
      requisicao.errors.invalid?(:objetivo_da_reserva).should be_true
    end

    it "O campo Descrição de Outros não deve ser nulo quando Objetivo da reserva
        for Outros" do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      requisicao = Factory.build :requisicao,
                                 :outros => "",
                                 :objetivo_da_reserva => "Outros",
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id
      requisicao.save.should be_false
      requisicao.errors.invalid?(:outros).should be_true
    end

    it "O campo Motivo não deve ser nulo quando Estado for Cancelado pelo
        Professor" do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      requisicao = Factory.build :requisicao,
                                 :estado => Requisicao::CANCELADO_PELO_PROFESSOR,
                                 :motivo_id => nil,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id
      requisicao.save.should be_false
      requisicao.errors.invalid?(:motivo).should be_true
    end

    it "A data de requisição deve ser marcada com no mínimo 2 dias de antecedência" do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      requisicao = Factory.build :requisicao,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :data_de_reserva => Date.tomorrow.tomorrow
      requisicao.save.should be_true
    end

    it "O ano da data de requisição tem que ser o mesmo do ano corrente" do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      requisicao = Factory.build :requisicao,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :data_de_reserva => Date.today.years_since(1)
      requisicao.save.should be_false
      requisicao.errors.invalid?(:data_de_reserva).should be_true
    end

    it "Para veículos diferentes de Ônibus, Micro-ônibus e Vans a data de
        requisição deve ser marcada com no máximo 15 dias de antecedência" do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo,
                                            :nome => "Automóvel até 4 passageiros"
      requisicao = Factory.build :requisicao,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :data_de_reserva => Date.today + 16.days
      requisicao.save.should be_false
      requisicao.errors.invalid?(:data_de_reserva).should be_true
    end
  end

  it "deve fornecer a lista de objetivos" do
    Requisicao.objetivo.should have(13).objetivo
    Requisicao.objetivo.should include("Selecione um Objetivo",
                                        "Aula de Campo",
                                        "Compras",
                                        "Malote ou Correspondência",
                                        "Trabalho de Campo",
                                        "Visita Técnica",
                                        "Transporte de Pessoal",
                                        "Transporte de Equipamento Natural",
                                        "Participações em Eventos (micro-ônibus",
                                        "Participações em Reuniões",
                                        "Serviços Administrativos",
                                        "Serviços Técnicos",
                                        "Outros")
  end

  it "Deve retornar falso caso não tenha marcado as regras" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    requisicao = Factory.build :requisicao,
                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                               :termo => "0"
    requisicao.save.should be_false
  end

  it "Deve retornar verdadeiro caso tenha marcado as regras" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    requisicao = Factory.build :requisicao,
                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                               :termo => "1"
    requisicao.save.should be_true
  end

  it "Deve retornar uma lista contendo 2 objetos de requisição" do
    solicitante = Factory.create :solicitante
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    dados = {:matricula => solicitante.matricula,
              :email => solicitante.email,
              :requisicao => {
                :nome_telefone_passageiros => "algum nome",
                :roteiro_da_agenda => "alguma agenda",
                :data_de_reserva => Date.today + 2.days,
                :categoria_de_veiculo_id => categoria_de_veiculo.id
              },
              :data_de_reserva_volta => Date.today + 3.days,
              :roteiro_da_agenda_volta => "roteiro de volta"
    }
    requisicao = Requisicao.analisar_requisicao dados
    requisicao.should have(2).requisicoes
  end

  it "Deve retornar uma lista contendo 1 objetos de requisição" do

  end

  it "Deve dar erro caso a data seja vazia" do
    requisicao = Factory.build :requisicao, :data_de_reserva => ""
    requisicao.save.should be_false
    requisicao.errors.invalid?(:data_de_reserva).should be_true
  end


  it "Deve salvar a requisição de ida e volta com os respectivos protocolos para
      a referência" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    requisicao_ida = Factory.build :requisicao,
                                   :categoria_de_veiculo_id => categoria_de_veiculo.id
    requisicao_volta = Factory.build :requisicao,
                                     :categoria_de_veiculo_id => categoria_de_veiculo.id

    confirmacao = requisicao_ida.registrarVolta requisicao_volta

    resultado = Requisicao.find(requisicao_ida.id)
    resultado.referencia_id.should == requisicao_volta.id.to_s

    resultado = Requisicao.find(requisicao_volta.id)
    resultado.referencia_id.should == requisicao_ida.id.to_s

    confirmacao.should be_true

  end

  it "Deve retornar um objeto com erros caso a requisição não seja válida" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    requisicao_ida = Factory.build :requisicao,
                                   :categoria_de_veiculo_id => categoria_de_veiculo.id
    requisicao_volta = Factory.build :requisicao,
                                     :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                     :objetivo_da_reserva => "Selecione um Objetivo"
    confirmacao = requisicao_ida.registrarVolta requisicao_volta

    confirmacao.valid?.should be false
  end

  it "Deve filtrar a requisição e retornar apenas as requisições com o estado selecionado" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    motivo = Factory.create :motivo, :descricao => "algum motivo"
    requisicao1 = Factory.create :requisicao, :estado => Requisicao::ESPERA, :categoria_de_veiculo_id => categoria_de_veiculo.id
    requisicao2 = Factory.create :requisicao, :estado => Requisicao::REJEITADA, :categoria_de_veiculo_id => categoria_de_veiculo.id, :motivo_id => motivo.id
    requisicao3 = Factory.create :requisicao, :estado => Requisicao::CANCELADO_PELO_PROFESSOR, :categoria_de_veiculo_id => categoria_de_veiculo.id, :motivo_professor => "algum motivo"
    requisicao4 = Factory.create :requisicao, :motivo_id => motivo.id, :estado => Requisicao::CANCELADO_PELO_SISTEMA, :categoria_de_veiculo_id => categoria_de_veiculo.id
    requisicao5 = Factory.create :requisicao, :estado => Requisicao::ACEITA, :categoria_de_veiculo_id => categoria_de_veiculo.id
    filtro = {:espera => "Espera",
              :rejeitada => "Rejeitada",
              :cancelada_pelo_professor => "Cancelada pelo Professor",
              :cancelada_pelo_sistema => "Cancelada pelo Sistema",
              :aceita => "Aceita"}
    Requisicao.filtrar(filtro[:espera]).should include(requisicao1)
    Requisicao.filtrar(filtro[:rejeitada]).should == requisicao2
    Requisicao.filtrar(filtro[:cancelada_pelo_professor]).should == requisicao3
    Requisicao.filtrar(filtro[:cancelada_pelo_sistema]).should == requisicao4
    Requisicao.filtrar(filtro[:aceita]).should == requisicao5
  end

  it "Deve verificar se uma requisição está em espera" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    requisicao = Factory.create :requisicao, :estado => Requisicao::ESPERA, :categoria_de_veiculo_id => categoria_de_veiculo.id
    Requisicao.em_espera?(requisicao).should be_true
  end

  it "Deve mudar o estado de uma requisição para Rejeitada" do
    motivo = Factory.create :motivo
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    requisicao = Factory.create :requisicao, :estado => Requisicao::ESPERA, :categoria_de_veiculo_id => categoria_de_veiculo.id
    requisicao.rejeitar motivo.id
    requisicao.estado.should == Requisicao::REJEITADA
    requisicao.motivo_id.should == motivo.id
  end


end

