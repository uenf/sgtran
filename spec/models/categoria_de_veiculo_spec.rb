require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CategoriaDeVeiculo do

  it "Deve criar uma nova instancia com valores válidos" do
    categoria_de_veiculo = Factory(:categoria_de_veiculo)
  end

  describe 'validar' do

    it 'número mínimo não pode ser maior do que o número máximo' do
      categoria_de_veiculo = Factory.build :categoria_de_veiculo,
                                              :numero_minimo_dias => 14,
                                              :numero_maximo_dias => 8
      categoria_de_veiculo.save.should be_false
    end

    it 'número mínimo não pode ser igual do que o número máximo, exceto 0' do
      categoria_de_veiculo = Factory.build :categoria_de_veiculo,
                                              :numero_minimo_dias => 8,
                                              :numero_maximo_dias => 8
      categoria_de_veiculo.save.should be_false

      categoria_de_veiculo.numero_minimo_dias = 0
      categoria_de_veiculo.numero_maximo_dias = 0
      categoria_de_veiculo.save.should be_true
    end

  end

  should_validate_presence_of :nome

end

