require 'spec_helper'

describe ConfiguracoesController do
  describe "routing" do

    it "recognizes and generates #edit" do
      { :get => "/configuracoes/1/edit" }.should route_to(:controller => "configuracoes", :action => "edit", :id => "1")
    end

    it "recognizes and generates #update" do
      { :put => "/configuracoes/1" }.should route_to(:controller => "configuracoes", :action => "update", :id => "1")
    end
  end
end

