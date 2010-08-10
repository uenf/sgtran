require 'spec_helper'

describe Prefixo do
  before(:each) do
    @valid_attributes = {
      :nome => "value for nome"
    }
  end

  it "should create a new instance given valid attributes" do
    Prefixo.create!(@valid_attributes)
  end

  it "deve ter nome para ser criado" do
    prefixo = Factory.build :prefixo, :nome => nil
    prefixo.save.should be false

    prefixo.nome = "Locado"
    prefixo.save.should be_true
  end

  it "deve retornar a lista de prefixos ativos" do
    prefixo_ativo = Factory.create :prefixo,
                                   :status => Prefixo::ATIVO
    prefixo_inativo = Factory.create :prefixo,
                                     :status => Prefixo::INATIVO
    Prefixo.ativos.should include(prefixo_ativo)
    Prefixo.ativos.should_not include(prefixo_inativo)
  end
end

