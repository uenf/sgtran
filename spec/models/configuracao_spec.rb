require 'spec_helper'

describe Configuracao do
  before(:each) do
    @valid_attributes = {
      :orgao_utilizador => "value for orgao_utilizador"
    }
  end

  it "should create a new instance given valid attributes" do
    Configuracao.create!(@valid_attributes)
  end

  it 'informar se a requisição pode ser feita somente no ano corrent' do
    configuracao = Factory.create :configuracao
    configuracao.requisicao_somente_este_ano?.should be_true

    configuracao.update_attribute(:ano_corrente, false)
    configuracao.requisicao_somente_este_ano?.should be_false
  end
end

