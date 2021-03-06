require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Requisicao do

   before(:each) do
     @configuracao = Factory.create :configuracao
   end

  it "deve aceitar uma requisição" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    requisicao = Factory.create :requisicao,
                                :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                :objetivo_de_reserva_id => objetivo_de_reserva.id
    requisicao.aceitar viagem
    requisicao.viagem_id.should == viagem.id
    requisicao.estado.should == Requisicao::ACEITA
  end

  describe "que já possuem uma viagem" do

    before(:each) do
      @configuracao ||= Factory.create :configuracao
      @configuracao.update_attribute(:ano_corrente, true)
      motorista = Factory.create :motorista
      @viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      objetivo_de_reserva = Factory.create :objetivo_de_reserva
      @viagem_2 = Factory.create :viagem, :motorista_ids => [motorista.id]
      @requisicao = Factory.create :requisicao,
                                  :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                  :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                  :estado => Requisicao::ACEITA,
                                  :viagem_id => @viagem.id
      @requisicao.aceitar @viagem_2
      @requisicao.reload
    end

    it "deve ser atendida pela nova viagem" do
      @requisicao.viagem_id.should == @viagem_2.id
      @requisicao.estado.should == Requisicao::ACEITA
    end

    it "deve apagar a viagem que ficou vazia" do
      lambda { Viagem.find(@viagem.id) }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "para alterar a viagem de uma requisição com uma viagem existente" do

    before(:each) do
      Viagem.delete_all
      motorista = Factory.create :motorista
      @viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
      @viagem_2 = Factory.create :viagem, :motorista_ids => [motorista.id]
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      objetivo_de_reserva = Factory.create :objetivo_de_reserva
      @requisicao = Factory.create :requisicao,
                                  :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                  :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                  :estado => Requisicao::ACEITA,
                                  :viagem_id => @viagem.id
      @requisicao.aceitar_com_viagem_existente @viagem_2.id
      @requisicao.reload
    end

    it "deve alterar a viagem" do
      @requisicao.viagem_id.should == @viagem_2.id
    end

    it "deve apagar a viagem que não atende mais requisições" do
      lambda { Viagem.find(@viagem.id) }.should raise_error(ActiveRecord::RecordNotFound)
    end

  end

  context "Validações:" do

    should_validate_presence_of :data_de_reserva,
                                :nome_telefone_passageiros,
                                :roteiro_da_agenda,
                                :celular

    it "O campo Categoria de veículo deve ser selecionado" do
      objetivo_de_reserva = Factory.create :objetivo_de_reserva
      requisicao = Factory.build :requisicao,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                 :categoria_de_veiculo_id => ""

      requisicao.save.should be_false
      requisicao.errors.invalid?(:categoria_de_veiculo).should be_true
    end

    it "O campo Objetivo da reserva deve ser selecionado" do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      requisicao = Factory.build :requisicao,
                                 :objetivo_de_reserva_id => "",
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id
      requisicao.save.should be_false
      requisicao.errors.invalid?(:objetivo_de_reserva).should be_true
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

    it "A data mínima e máxima deve varia de acordo com a categoria de veículo" do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo,
                                              :numero_minimo_dias => 4,
                                              :numero_maximo_dias => 8
      objetivo_de_reserva = Factory.create :objetivo_de_reserva
      requisicao = Factory.build :requisicao,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                 :data_de_reserva => Date.today + 2.days
      requisicao.save.should be_false

      requisicao.data_de_reserva = Date.today + 10.days
      requisicao.save.should be_false
    end

    it 'observações não pode ser vazio caso o objetivo de reserva requeira' do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      objetivo_de_reserva = Factory.create :objetivo_de_reserva, :obrigatorio => true
      requisicao = Factory.build :requisicao,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                 :observacao => ''
      requisicao.save.should be_false

      objetivo_de_reserva.update_attribute(:obrigatorio, false)
      requisicao_2 = Factory.build :requisicao,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                 :observacao => ''
      requisicao_2.save.should be_true
    end

    describe 'ano da data de requisição' do

      @configuracao ||= Factory.create :configuracao
      it "o mesmo do ano corrente" do
        @configuracao.update_attribute(:ano_corrente, true)
        categoria_de_veiculo = Factory.create :categoria_de_veiculo,
                                                :numero_minimo_dias => 0,
                                                :numero_maximo_dias => 0
        objetivo_de_reserva = Factory.create :objetivo_de_reserva
        requisicao = Factory.build :requisicao,
                                   :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                   :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                   :data_de_reserva => Date.today.years_since(1)
        requisicao.save.should be_false
        requisicao.errors.invalid?(:data_de_reserva).should be_true
      end

      it "qualquer ano" do
        Configuracao.delete_all
        @configruacao = Factory.create :configuracao, :ano_corrente => false

        categoria_de_veiculo = Factory.create :categoria_de_veiculo,
                                                :numero_minimo_dias => 0,
                                                :numero_maximo_dias => 0
        objetivo_de_reserva = Factory.create :objetivo_de_reserva
        requisicao = Factory.build :requisicao,
                                   :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                   :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                   :data_de_reserva => Date.today.years_since(1)
        requisicao.save.should be_true
      end

    end

    describe 'impedir requisição para o fim de semana' do

      it 'sexta-feira após 18h' do
        # Define o time para 17/12/2010 (uma sexta-feira) às 18:00
        novo_tempo = Time.local(2010, 12, 17, 18, 0, 0)
        Timecop.freeze(novo_tempo) do

          categoria_de_veiculo = Factory.create :categoria_de_veiculo,
                                                  :numero_minimo_dias => 0,
                                                  :numero_maximo_dias => 0
          objetivo_de_reserva = Factory.create :objetivo_de_reserva
          requisicao = []

          # Sexta-feira, Sábado, Domingo, Segunda-feira às 18h
          (0..3).each do |i|
            requisicao[i] = Factory.build :requisicao,
                             :categoria_de_veiculo_id => categoria_de_veiculo.id,
                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                             :data_de_reserva => Date.today + i.days
          end
          (0..3).each do |i|
            requisicao[i].para_o_fim_de_semana?.should be_true
            requisicao[i].save.should be_false
            requisicao[i].errors.to_a.should include(["base","Requisição não pode ser feita após o expediente para o fim de semana."])
          end
        end

        # Define o time para 17/12/2010 às 17:59 para testar a requisição para Segunda-feira
        novo_tempo = Time.local(2010, 12, 17, 17, 59, 0)
        Timecop.freeze(novo_tempo) do
          categoria_de_veiculo = Factory.create :categoria_de_veiculo,
                                                  :numero_minimo_dias => 0,
                                                  :numero_maximo_dias => 0
          objetivo_de_reserva = Factory.create :objetivo_de_reserva
          requisicao = Factory.build :requisicao,
                             :categoria_de_veiculo_id => categoria_de_veiculo.id,
                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                             :data_de_reserva => Date.today + 3.days
          requisicao.para_o_fim_de_semana?.should be_false
          requisicao.save.should be_true
        end
      end

      it 'sábado qualquer horário' do
        novo_tempo = Time.local(2010, 12, 18, 13, 59, 0)
        Timecop.freeze(novo_tempo) do
          categoria_de_veiculo = Factory.create :categoria_de_veiculo,
                                                  :numero_minimo_dias => 0,
                                                  :numero_maximo_dias => 0
          objetivo_de_reserva = Factory.create :objetivo_de_reserva
          requisicao = []

          # Sábado, Domingo, Segunda-feira
          (0..2).each do |i|
            requisicao[i] = Factory.build :requisicao,
                             :categoria_de_veiculo_id => categoria_de_veiculo.id,
                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                             :data_de_reserva => Date.today + i.days
          end

          (0..2).each do |i|
            requisicao[i].para_o_fim_de_semana?.should be_true
            requisicao[i].save.should be_false
          end
        end
      end

      it 'domingo qualquer horário' do
        novo_tempo = Time.local(2010, 12, 19, 13, 59, 0)
        Timecop.freeze(novo_tempo) do
          categoria_de_veiculo = Factory.create :categoria_de_veiculo,
                                                  :numero_minimo_dias => 0,
                                                  :numero_maximo_dias => 0
          objetivo_de_reserva = Factory.create :objetivo_de_reserva
          requisicao = []

          # Domingo, Segunda-feira
          (0..2).each do |i|
            requisicao[i] = Factory.build :requisicao,
                             :categoria_de_veiculo_id => categoria_de_veiculo.id,
                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                             :data_de_reserva => Date.today + i.days
          end

          (0..1).each do |i|
            requisicao[i].para_o_fim_de_semana?.should be_true
            requisicao[i].save.should be_false
          end

          requisicao[2].para_o_fim_de_semana?.should be_false
          requisicao[2].save.should be_true
        end
      end

    end

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
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    requisicao = Factory.build :requisicao,
                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                               :objetivo_de_reserva_id => objetivo_de_reserva.id,
                               :termo => "1"
    requisicao.save.should be_true
  end

  it "Deve verificar se os dados do formulário de requisição são válidos" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    requisicao = Factory.build :requisicao,
                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                               :objetivo_de_reserva_id => objetivo_de_reserva.id
    centro = Factory.create :centro
    Factory.create :solicitante, :centro_id => centro.id
    solicitante = Factory.build :solicitante, :centro_id => centro.id
    requisicao.analisar_requisicao(solicitante).should be_true
  end

  it "Deve dar erro caso a data seja vazia" do
    requisicao = Factory.build :requisicao, :data_de_reserva => ""
    requisicao.save.should be_false
    requisicao.errors.invalid?(:data_de_reserva).should be_true
  end

  it "Deve filtrar a requisição e retornar apenas as requisições com o estado selecionado" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    motivo = Factory.create :motivo, :descricao => "algum motivo"
    requisicao1 = Factory.create :requisicao,
                                 :estado => Requisicao::ESPERA,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id
    requisicao2 = Factory.create :requisicao,
                                 :estado => Requisicao::REJEITADA,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                 :motivo_id => motivo.id
    requisicao3 = Factory.create :requisicao,
                                 :estado => Requisicao::CANCELADO_PELO_PROFESSOR,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                 :motivo_professor => "algum motivo"
    requisicao4 = Factory.create :requisicao,
                                 :motivo_id => motivo.id,
                                 :estado => Requisicao::CANCELADO_PELO_SISTEMA,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id
    requisicao5 = Factory.create :requisicao,
                                 :estado => Requisicao::ACEITA,
                                 :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                 :objetivo_de_reserva_id => objetivo_de_reserva.id
    filtro = {:espera => "Espera",
              :rejeitada => "Rejeitada",
              :cancelada_pelo_professor => "Cancelada pelo Professor",
              :cancelada_pelo_sistema => "Cancelada pelo Sistema",
              :aceita => "Aceita"}
    Requisicao.filtrar(filtro[:espera]).should include(requisicao1)
    Requisicao.filtrar(filtro[:rejeitada]).should include requisicao2
    Requisicao.filtrar(filtro[:cancelada_pelo_professor]).should include requisicao3
    Requisicao.filtrar(filtro[:cancelada_pelo_sistema]).should include requisicao4
    Requisicao.filtrar(filtro[:aceita]).should include requisicao5
  end

  it "Deve verificar se uma requisição está em espera" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    requisicao = Factory.create :requisicao,
                                :estado => Requisicao::ESPERA,
                                :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                :objetivo_de_reserva_id => objetivo_de_reserva.id
    requisicao.esta_em_espera?.should be_true
  end

  it "Deve verificar que uma requisição em epera pode ser aceita" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    requisicao = Factory.create :requisicao,
                                :estado => Requisicao::ESPERA,
                                :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                :objetivo_de_reserva_id => objetivo_de_reserva.id
    requisicao.pode_ser_aceita?.should be_true
  end

  it "Deve verificar que uma requisição rejeitada pode ser aceita" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    motivo = Factory.create :motivo, :descricao => "algum motivo"
    requisicao = Factory.create :requisicao,
                                :estado => Requisicao::REJEITADA,
                                :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                :motivo_id => motivo.id
    requisicao.pode_ser_aceita?.should be_true
  end

  it "Deve verificar que uma requisição aceita pode ser aceita navamente (com outra viagem)" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    requisicao = Factory.create :requisicao,
                                :estado => Requisicao::ACEITA,
                                :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                :objetivo_de_reserva_id => objetivo_de_reserva.id
    requisicao.pode_ser_aceita?.should be_true
  end

  it "Deve verificar que uma requisição cancelada pelo professor não pode ser aceita" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    requisicao = Factory.create :requisicao,
                                :estado => Requisicao::CANCELADO_PELO_PROFESSOR,
                                :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                :motivo_professor => "algum motivo"
    requisicao.pode_ser_aceita?.should be_false
  end

  it "Deve verificar que uma requisição cancelada pelo sistema não pode ser aceita" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    motivo = Factory.create :motivo, :descricao => "algum motivo"
    requisicao = Factory.create :requisicao,
                                :estado => Requisicao::CANCELADO_PELO_SISTEMA,
                                :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                :motivo_id => motivo.id
    requisicao.pode_ser_aceita?.should be_false
  end

  it "Deve mudar o estado de uma requisição para Rejeitada" do
    motivo = Factory.create :motivo
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    solicitante = Factory.create :solicitante
    corpo_email = "Corpo do E-mail"
    destinatários = ""
    requisicao = Factory.create :requisicao,
                                :estado => Requisicao::ESPERA,
                                :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                :solicitante_id => solicitante.id
    requisicao.rejeitar motivo.id
    requisicao.estado.should == Requisicao::REJEITADA
    requisicao.motivo_id.should == motivo.id
  end

  it "Deve verificar se o estado da requisição é Em Espera" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    motivo = Factory.create :motivo
    requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id, :objetivo_de_reserva_id => objetivo_de_reserva.id
    requisicao.esta_em_espera?.should be_true
    requisicao.motivo_id = motivo.id

    requisicao.estado = Requisicao::CANCELADO_PELO_SISTEMA
    requisicao.esta_em_espera?.should be_false

    requisicao.estado = Requisicao::CANCELADO_PELO_PROFESSOR
    requisicao.esta_em_espera?.should be_false

    requisicao.estado = Requisicao::ACEITA
    requisicao.esta_em_espera?.should be_false

    requisicao.estado = Requisicao::REJEITADA
    requisicao.esta_em_espera?.should be_false
  end

  it "Deve verificar se o estado da requisição é Aceita" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    motivo = Factory.create :motivo
    requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :estado => Requisicao::ACEITA
    requisicao.esta_aceita?.should be_true
    requisicao.motivo_id = motivo.id

    requisicao.estado = Requisicao::CANCELADO_PELO_SISTEMA
    requisicao.esta_aceita?.should be_false

    requisicao.estado = Requisicao::CANCELADO_PELO_PROFESSOR
    requisicao.esta_aceita?.should be_false

    requisicao.estado = Requisicao::ESPERA
    requisicao.esta_aceita?.should be_false

    requisicao.estado = Requisicao::REJEITADA
    requisicao.esta_aceita?.should be_false
  end

  it "Deve cancelar uma requisição" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    motivo = Factory.create :motivo
    solicitante = Factory.create :solicitante
    corpo_do_email = "Corpo do E-mail"
    destinatarios = ""
    requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :estado => Requisicao::ACEITA,
                                             :viagem_id => viagem.id,
                                             :solicitante_id => solicitante.id

    requisicao.cancelar_requisicao motivo.id, corpo_do_email, destinatarios
    requisicao.estado.should == Requisicao::CANCELADO_PELO_SISTEMA
    requisicao.motivo_id.should == motivo.id
    requisicao.viagem_id.should == nil
  end

  it "Caso a requisição esteja ligada a uma viagem, a viagem tenha apenas essa requisição e a requisição é cancelada, a viagem deve ser cancelada" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
    viagem_id = viagem.id
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    motivo = Factory.create :motivo
    solicitante = Factory.create :solicitante
    corpo_do_email = "Corpo do E-mail"
    destinatarios = ""
    requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :estado => Requisicao::ACEITA,
                                             :viagem_id => viagem.id,
                                             :solicitante_id => solicitante.id

    requisicao.cancelar_requisicao motivo.id, corpo_do_email, destinatarios
    requisicao.estado.should == Requisicao::CANCELADO_PELO_SISTEMA
    requisicao.motivo_id.should == motivo.id
    requisicao.viagem_id.should == nil
    Viagem.all.collect(&:id).should_not include(viagem_id)
  end

  it "Deve verificar se uma requisição está no estado Rejeitada" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    motivo = Factory.create :motivo
    requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :estado => Requisicao::REJEITADA,
                                             :motivo_id => motivo.id
    requisicao.esta_rejeitada?.should be_true
  end

  it "Deve verificar se a viagem de uma requisição pode ser alterada" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    motivo = Factory.create :motivo
    requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id
    requisicao.pode_alterar_viagem?.should be_false
    requisicao.estado = Requisicao::ACEITA
    requisicao.viagem_id = viagem.id
    requisicao.pode_alterar_viagem?.should be_true
  end

  it "Deve alterar a viagem que atende a requisicao" do
    motorista = Factory.create :motorista
    viagem_1 = Factory.create :viagem, :motorista_ids => [motorista.id]
    viagem_2 = Factory.create :viagem, :motorista_ids => [motorista.id]
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    motivo = Factory.create :motivo
    requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :estado => Requisicao::ACEITA,
                                             :viagem_id => viagem_1.id
    requisicao.alterar_viagem viagem_2.id
    requisicao.viagem_id.should == viagem_2.id

  end

  it "deve buscar requisições pelo nome do solicitante" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    solicitante_1 = Factory.create :solicitante, :nome => "Solicitante 1"
    solicitante_2 = Factory.create :solicitante, :nome => "Solicitante 2"
    nome = "Solicitante 1"
    requisicao_1 = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :solicitante_id => solicitante_1.id

    requisicao_2 = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :solicitante_id => solicitante_2.id
    Requisicao.buscar_por_nome_de_solicitante(nome).should include(requisicao_1)
    Requisicao.buscar_por_nome_de_solicitante(nome).should_not include(requisicao_2)
  end

  it "deve buscar requisições pelo intervalo de data informado" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    solicitante_1 = Factory.create :solicitante, :nome => "Solicitante 1"
    solicitante_2 = Factory.create :solicitante, :nome => "Solicitante 2"
    requisicao_1 = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :solicitante_id => solicitante_1.id,
                                             :data_de_reserva => Date.today + 2.days

    requisicao_2 = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :solicitante_id => solicitante_2.id,
                                             :data_de_reserva => Date.today + 3.days
    data_inicio = (Date.today  + 3.days).strftime("%d/%m/%Y")
    data_fim = (Date.today + 4.days).strftime("%d/%m/%Y")
    Requisicao.buscar_por_data(data_inicio, data_fim).should include(requisicao_2)
    Requisicao.buscar_por_data(data_inicio, data_fim).should_not include(requisicao_1)
    data_inicio = (Date.today  + 5.days).strftime("%d/%m/%Y")
    data_fim = (Date.today + 6.days).strftime("%d/%m/%Y")
    Requisicao.buscar_por_data(data_inicio, data_fim).should be_empty
  end

  it "deve buscar uma requisição pelo número de protocolo" do
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    solicitante = Factory.create :solicitante, :nome => "Solicitante 1"
    requisicao_1 = Factory.create :requisicao, :id => 13,
                                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                               :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                               :solicitante_id => solicitante.id

    requisicao_2 = Factory.create :requisicao, :id => 15,
                                               :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                               :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                               :solicitante_id => solicitante.id
    Requisicao.buscar_por_protocolo(13).should include(requisicao_1)
    Requisicao.buscar_por_protocolo(13).should_not include(requisicao_2)
  end

  it "não deve cancelar uma requisição com estado de 'Finalizada'" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    motivo = Factory.create :motivo
    solicitante = Factory.create :solicitante
    requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :viagem_id => viagem.id,
                                             :solicitante_id => solicitante.id,
                                             :estado => Requisicao::FINALIZADA

    requisicao.cancelar_pelo_professor("algum motivo")
    requisicao.reload
    requisicao.estado.should == Requisicao::FINALIZADA
    requisicao.motivo_id.should == nil
    requisicao.viagem_id.should == viagem.id
  end

  it "deve verificar se a requisição pode ser cancelada" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    solicitante = Factory.create :solicitante
    requisicao_1 = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :viagem_id => viagem.id,
                                             :solicitante_id => solicitante.id,
                                             :estado => Requisicao::FINALIZADA
    requisicao_2 = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :viagem_id => viagem.id,
                                             :solicitante_id => solicitante.id,
                                             :estado => Requisicao::ESPERA
    requisicao_1.pode_ser_cancelada_pelo_professor?.should be_false
    requisicao_2.pode_ser_cancelada_pelo_professor?.should be_true
  end

  it "deve verificar se uma requisição pode ser finalizada" do
    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    solicitante = Factory.create :solicitante
    requisicao_1 = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :viagem_id => viagem.id,
                                             :solicitante_id => solicitante.id,
                                             :estado => Requisicao::ESPERA
    requisicao_2 = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :viagem_id => viagem.id,
                                             :solicitante_id => solicitante.id,
                                             :estado => Requisicao::ACEITA

    requisicao_1.pode_ser_finalizada?.should be_false
    requisicao_2.pode_ser_finalizada?.should be_true
  end

  describe "deve atualizar" do

    motorista = Factory.create :motorista
    viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
    categoria_de_veiculo = Factory.create :categoria_de_veiculo
    objetivo_de_reserva = Factory.create :objetivo_de_reserva
    solicitante = Factory.create :solicitante
    estado = Factory.create :estado, :sigla => "RJ"
    cidade_1 = Factory.create :cidade,
                              :nome => "Campos dos Goytacazes",
                              :estado_id => estado.id
    cidade_2 = Factory.create :cidade,
                              :nome => "Campos dos Goytacazes",
                              :estado_id => estado.id
    requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                             :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                             :viagem_id => viagem.id,
                                             :solicitante_id => solicitante.id,
                                             :estado => Requisicao::ACEITA

    it "cidade de origem" do
      Requisicao.atualizar_origem_destino({requisicao.id => cidade_1.id}, {})
      requisicao.reload
      requisicao.local_origem_id.should == cidade_1.id
    end

    it "cidade de destino" do
    end

  end

  describe 'verificar se é possível excluir uma requisição' do

    it 'sem viagem' do
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      objetivo_de_reserva = Factory.create :objetivo_de_reserva
      solicitante = Factory.create :solicitante
      requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                               :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                               :solicitante_id => solicitante.id
      requisicao.pode_ser_excluida?.should be_true
    end

    it 'com viagem' do
      motorista = Factory.create :motorista
      viagem = Factory.create :viagem, :motorista_ids => [motorista.id]
      categoria_de_veiculo = Factory.create :categoria_de_veiculo
      objetivo_de_reserva = Factory.create :objetivo_de_reserva
      solicitante = Factory.create :solicitante
      requisicao = Factory.create :requisicao, :categoria_de_veiculo_id => categoria_de_veiculo.id,
                                               :objetivo_de_reserva_id => objetivo_de_reserva.id,
                                               :viagem_id => viagem.id,
                                               :solicitante_id => solicitante.id,
                                               :estado => Requisicao::ESPERA
      requisicao.pode_ser_excluida?.should be_false
    end

  end


end

