require 'spec_helper'

describe CidadesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/cidades" }.should route_to(:controller => "cidades", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/cidades/new" }.should route_to(:controller => "cidades", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/cidades/1" }.should route_to(:controller => "cidades", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/cidades/1/edit" }.should route_to(:controller => "cidades", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/cidades" }.should route_to(:controller => "cidades", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/cidades/1" }.should route_to(:controller => "cidades", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/cidades/1" }.should route_to(:controller => "cidades", :action => "destroy", :id => "1") 
    end
  end
end
