require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CategoriaDeVeiculo do

  it "Deve criar uma nova instancia com valores válidos" do
    categoria_de_veiculo = Factory(:categoria_de_veiculo)
  end

  should_validate_presence_of :nome

end

