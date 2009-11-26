require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Combustivel do
  it "Deve criar uma nova instancia com valores válidos" do
    combustivel = Factory(:combustivel)
  end

  should_validate_presence_of :nome
end

