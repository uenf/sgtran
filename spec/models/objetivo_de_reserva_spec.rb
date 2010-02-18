require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ObjetivoDeReserva do
  it "Deve criar uma nova instancia com valores válidos" do
    combustivel = Factory(:objetivo_de_reserva)
  end

  should_validate_presence_of :texto
end

