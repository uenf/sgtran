require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Veiculo do

  it "Deve criar uma nova instancia com valores válidos" do
    categoria = Factory(:categoria_de_veiculo)
    veiculo = Factory.create :veiculo, :categoria_de_veiculo_id => categoria.id
  end

end

