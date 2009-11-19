require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe VeiculosController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "veiculos", :action => "index").should == "/veiculos"
    end

    it "maps #new" do
      route_for(:controller => "veiculos", :action => "new").should == "/veiculos/new"
    end

    it "maps #show" do
      route_for(:controller => "veiculos", :action => "show", :id => "1").should == "/veiculos/1"
    end

    it "maps #edit" do
      route_for(:controller => "veiculos", :action => "edit", :id => "1").should == "/veiculos/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "veiculos", :action => "create").should == {:path => "/veiculos", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "veiculos", :action => "update", :id => "1").should == {:path =>"/veiculos/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "veiculos", :action => "destroy", :id => "1").should == {:path =>"/veiculos/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/veiculos").should == {:controller => "veiculos", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/veiculos/new").should == {:controller => "veiculos", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/veiculos").should == {:controller => "veiculos", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/veiculos/1").should == {:controller => "veiculos", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/veiculos/1/edit").should == {:controller => "veiculos", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/veiculos/1").should == {:controller => "veiculos", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/veiculos/1").should == {:controller => "veiculos", :action => "destroy", :id => "1"}
    end
  end
end
