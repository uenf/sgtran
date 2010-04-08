require 'spec_helper'

describe CentrosController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/centros" }.should route_to(:controller => "centros", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/centros/new" }.should route_to(:controller => "centros", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/centros/1" }.should route_to(:controller => "centros", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/centros/1/edit" }.should route_to(:controller => "centros", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/centros" }.should route_to(:controller => "centros", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/centros/1" }.should route_to(:controller => "centros", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/centros/1" }.should route_to(:controller => "centros", :action => "destroy", :id => "1") 
    end
  end
end
