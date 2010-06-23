require 'spec_helper'

describe BdtsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/bdts" }.should route_to(:controller => "bdts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/bdts/new" }.should route_to(:controller => "bdts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/bdts/1" }.should route_to(:controller => "bdts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/bdts/1/edit" }.should route_to(:controller => "bdts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/bdts" }.should route_to(:controller => "bdts", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/bdts/1" }.should route_to(:controller => "bdts", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/bdts/1" }.should route_to(:controller => "bdts", :action => "destroy", :id => "1") 
    end
  end
end
