require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SolicitantesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "solicitantes", :action => "index").should == "/solicitantes"
    end

    it "maps #new" do
      route_for(:controller => "solicitantes", :action => "new").should == "/solicitantes/new"
    end

    it "maps #show" do
      route_for(:controller => "solicitantes", :action => "show", :id => "1").should == "/solicitantes/1"
    end

    it "maps #edit" do
      route_for(:controller => "solicitantes", :action => "edit", :id => "1").should == "/solicitantes/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "solicitantes", :action => "create").should == {:path => "/solicitantes", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "solicitantes", :action => "update", :id => "1").should == {:path =>"/solicitantes/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "solicitantes", :action => "destroy", :id => "1").should == {:path =>"/solicitantes/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/solicitantes").should == {:controller => "solicitantes", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/solicitantes/new").should == {:controller => "solicitantes", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/solicitantes").should == {:controller => "solicitantes", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/solicitantes/1").should == {:controller => "solicitantes", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/solicitantes/1/edit").should == {:controller => "solicitantes", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/solicitantes/1").should == {:controller => "solicitantes", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/solicitantes/1").should == {:controller => "solicitantes", :action => "destroy", :id => "1"}
    end
  end
end
