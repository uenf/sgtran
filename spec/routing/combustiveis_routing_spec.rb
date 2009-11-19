require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CombustiveisController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "combustiveis", :action => "index").should == "/combustiveis"
    end

    it "maps #new" do
      route_for(:controller => "combustiveis", :action => "new").should == "/combustiveis/new"
    end

    it "maps #show" do
      route_for(:controller => "combustiveis", :action => "show", :id => "1").should == "/combustiveis/1"
    end

    it "maps #edit" do
      route_for(:controller => "combustiveis", :action => "edit", :id => "1").should == "/combustiveis/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "combustiveis", :action => "create").should == {:path => "/combustiveis", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "combustiveis", :action => "update", :id => "1").should == {:path =>"/combustiveis/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "combustiveis", :action => "destroy", :id => "1").should == {:path =>"/combustiveis/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/combustiveis").should == {:controller => "combustiveis", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/combustiveis/new").should == {:controller => "combustiveis", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/combustiveis").should == {:controller => "combustiveis", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/combustiveis/1").should == {:controller => "combustiveis", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/combustiveis/1/edit").should == {:controller => "combustiveis", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/combustiveis/1").should == {:controller => "combustiveis", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/combustiveis/1").should == {:controller => "combustiveis", :action => "destroy", :id => "1"}
    end
  end
end
