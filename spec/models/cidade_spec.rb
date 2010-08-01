require 'spec_helper'

describe Cidade do

  describe "válida" do

    it "deve ter um nome" do
      cidade = Factory.build :cidade, :nome => ""
      cidade.valid?.should be_false
    end

    it "deve ter um estado" do
      cidade = Factory.build :cidade, :estado_id => nil
      cidade.valid?.should be_false
    end

  end

end

