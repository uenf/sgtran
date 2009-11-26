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

end

