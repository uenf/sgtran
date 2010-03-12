require 'spec_helper'

describe PrediosController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/predios" }.should route_to(:controller => "predios", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/predios/new" }.should route_to(:controller => "predios", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/predios/1" }.should route_to(:controller => "predios", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/predios/1/edit" }.should route_to(:controller => "predios", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/predios" }.should route_to(:controller => "predios", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/predios/1" }.should route_to(:controller => "predios", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/predios/1" }.should route_to(:controller => "predios", :action => "destroy", :id => "1") 
    end
  end
end
