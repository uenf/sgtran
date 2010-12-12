require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ObjetivoDeReserva do
  it "Deve criar uma nova instancia com valores válidos" do
    combustivel = Factory(:objetivo_de_reserva)
  end

  it 'retornar se é obrigatório ou não' do
    obj_1 = Factory.build :objetivo_de_reserva
    obj_2 = Factory.build :objetivo_de_reserva, :obrigatorio => true

    obj_1.eh_obrigatorio?.should be_false
    obj_2.eh_obrigatorio?.should be_true
  end

  should_validate_presence_of :texto
end

