require 'spec_helper'

describe Estado do

  describe "válido" do

    it "deve ter um nome" do
      estado = Factory.build :estado, :nome => ""
      estado.valid?.should be_false
    end

    it "deve ter uma sigla" do
      estado = Factory.build :estado, :sigla => ""
      estado.valid?.should be_false
    end

  end

end

