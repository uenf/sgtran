require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Requisicao do

  before(:each) do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    @valid_attributes = {
      :solicitante_id => "5",
      :cargo_ou_funcao => "professor",
      :telefone_ou_ramal => "22222",
      :celular => "2020202",
      :laboratorio_ou_setor => "LBR",
      :predio => "P5",
      :andar => "3º",
      :sala => "109",
      :data_de_reserva => Date.tomorrow.tomorrow,
      :categoria_de_veiculo_id => categoria_de_veiculo.id,
      :objetivo_da_reserva => "gasvchgsvchjsvdc",
      :outros => "vfdsvdfvfdv",
      :nome_telefone_passageiros => "fhjdsvcdsvghsvd",
      :roteiro_da_agenda => "djvsdghvsvdsv",
      :observacao => "bfdbfdbdfbfdbd",
      :chave_de_seguranca => "a6170a5d995e53fe01f9b02f60e3bbc1c2bfcc74",
      :estado => Requisicao::ESPERA,
      :motivo => "",
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
                                  Date.tomorrow.tomorrow,
                                  Date.tomorrow.tomorrow,
                                  "10:00")

    requisicao.estado.should == Requisicao::ACEITA
  end

  context "Validações:" do

      should_validate_presence_of :cargo_ou_funcao,
                                  :telefone_ou_ramal,
                                  :laboratorio_ou_setor,
                                  :sala,
                                  :data_de_reserva,
                                  :nome_telefone_passageiros,
                                  :roteiro_da_agenda

    it "O campo Prédio deve ser diferente de Selecione um Prédio" do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      requisicao = Factory.build :requisicao, :predio => "Selecione um Prédio",
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id
      requisicao.save.should be_false
      requisicao.errors.invalid?(:predio).should be_true
    end

    it "O campo Andar deve ser diferente de Selecione um Andar" do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      requisicao = Factory.build :requisicao, :andar => "Selecione um Andar",
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id
      requisicao.save.should be_false
      requisicao.errors.invalid?(:andar).should be_true
    end

    it "O campo Categoria de veículo deve ser selecionado" do
      requisicao = Factory.build :requisicao, :categoria_de_veiculo_id => 0
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
                                 :motivo => "",
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

  it "deve fornecer a lista de prédios" do
    Requisicao.predio.should have(17).predio
    Requisicao.predio.should include("Selecione um Prédio",
                                      "Reitoria - E1",
                                      "CCT - Prédio",
                                      "CCT - Anexo",
                                      "CCT - Oficinas",
                                      "CBB - Prédio",
                                      "CBB - Anexo",
                                      "CCTA - Prédio",
                                      "CCTA - Anexo",
                                      "CCTA - Pesagro",
                                      "CCTA - Escola Agrícola",
                                      "CCTA - Itaocara",
                                      "CCH - Prédio",
                                      "P4",
                                      "P5",
                                      "Villa Maria",
                                      "LENEP - Macaé")
  end

  it "deve fornecer a lista de andares" do
    Requisicao.andar.should have(4).andar
    Requisicao.andar.should include("Selecione um Andar",
                                    "Térreo",
                                    "1º andar",
                                    "2º andar")
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

  it "deve instanciar um objeto requisição dados os atributos próprios, os dados
      do solicitante e a categoria de veículo" do
    dados_solicitante = {:matricula => "01210", :email => "professor@uenf.br"}
    solicitante = Factory.create :solicitante, dados_solicitante
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    requisicao = Requisicao.verificarSolicitante dados_solicitante,
                                      {:cargo_ou_funcao => "asdasdasd",
                                        :telefone_ou_ramal => "asdasdasd",
                                        :laboratorio_ou_setor => "asdasdasd",
                                        :sala => "asdasdasd",
                                        :data_de_reserva_br => (Date.today + 2.days).to_date.to_s_br,
                                        :nome_telefone_passageiros  => "asdasdasd",
                                        :roteiro_da_agenda  => "asdasdasd",
                                        :andar => "asdasdasd",
                                        :predio => "asdasdasd",
                                        :categoria_de_veiculo_id => categoria_de_veiculo.id
                                      }
    requisicao.should_not be_nil
    requisicao.should be_valid
    requisicao.solicitante_id.should == solicitante.id
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
    dados_solicitante = {:matricula => "01210", :email => "professor@uenf.br"}
    solicitante = Factory.create :solicitante, dados_solicitante
    dados_requisicao = {:cargo_ou_funcao => "asdasdasd",
                        :telefone_ou_ramal => "asdasdasd",
                        :laboratorio_ou_setor => "asdasdasd",
                        :predio => "Reitoria - E1",
                        :andar => "Térreo",
                        :sala => "asdasdasd",
                        :data_de_reserva_br => (Date.today + 2.days).to_date.to_s_br,
                        :nome_telefone_passageiros  => "asdasdasd",
                        :roteiro_da_agenda  => "asdasdasd"
                        }

    requisicao = Requisicao.instanciarRequisicoes(dados_requisicao,
                Date.tomorrow.tomorrow.tomorrow.to_date.to_s_br,
                "volta", dados_requisicao[:roteiro_da_agenda], solicitante.id)
    requisicao.should have(2).requisicoes
  end

  it "Deve retornar uma lista contendo 1 objetos de requisição" do
    dados_solicitante = {:matricula => "01210", :email => "professor@uenf.br"}
    solicitante = Factory.create :solicitante, dados_solicitante
    dados_requisicao = {:cargo_ou_funcao => "asdasdasd",
                        :telefone_ou_ramal => "asdasdasd",
                        :laboratorio_ou_setor => "asdasdasd",
                        :predio => "Reitoria - E1",
                        :andar => "Térreo",
                        :sala => "asdasdasd",
                        :data_de_reserva_br => (Date.today + 2.days).to_date.to_s_br,
                        :nome_telefone_passageiros  => "asdasdasd",
                        :roteiro_da_agenda  => "asdasdasd"
                        }

        requisicao = Requisicao.instanciarRequisicoes(dados_requisicao,
                "",
                "ida", dados_requisicao[:roteiro_da_agenda], solicitante.id)

    requisicao.should have(1).requisicoes
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
                                   :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                   :cargo_ou_funcao => ""
    requisicao_volta = Factory.build :requisicao,
                                     :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                     :cargo_ou_funcao => "Selecione um cargo"
    confirmacao = requisicao_ida.registrarVolta requisicao_volta

    confirmacao.valid?.should be false
  end

end

