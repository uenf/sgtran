require 'spec_helper'

describe PrefixosController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/prefixos" }.should route_to(:controller => "prefixos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/prefixos/new" }.should route_to(:controller => "prefixos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/prefixos/1" }.should route_to(:controller => "prefixos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/prefixos/1/edit" }.should route_to(:controller => "prefixos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/prefixos" }.should route_to(:controller => "prefixos", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/prefixos/1" }.should route_to(:controller => "prefixos", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/prefixos/1" }.should route_to(:controller => "prefixos", :action => "destroy", :id => "1") 
    end
  end
end
