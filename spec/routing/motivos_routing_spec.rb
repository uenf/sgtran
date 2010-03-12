require 'spec_helper'

describe MotivosController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/motivos" }.should route_to(:controller => "motivos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/motivos/new" }.should route_to(:controller => "motivos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/motivos/1" }.should route_to(:controller => "motivos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/motivos/1/edit" }.should route_to(:controller => "motivos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/motivos" }.should route_to(:controller => "motivos", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/motivos/1" }.should route_to(:controller => "motivos", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/motivos/1" }.should route_to(:controller => "motivos", :action => "destroy", :id => "1") 
    end
  end
end
