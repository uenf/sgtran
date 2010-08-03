require 'spec_helper'

describe EstadosController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/estados" }.should route_to(:controller => "estados", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/estados/new" }.should route_to(:controller => "estados", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/estados/1" }.should route_to(:controller => "estados", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/estados/1/edit" }.should route_to(:controller => "estados", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/estados" }.should route_to(:controller => "estados", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/estados/1" }.should route_to(:controller => "estados", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/estados/1" }.should route_to(:controller => "estados", :action => "destroy", :id => "1") 
    end
  end
end
