require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsuarioSessionsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "usuario_sessions", :action => "index").should == "/usuario_sessions"
    end

    it "maps #new" do
      route_for(:controller => "usuario_sessions", :action => "new").should == "/usuario_sessions/new"
    end

    it "maps #show" do
      route_for(:controller => "usuario_sessions", :action => "show", :id => "1").should == "/usuario_sessions/1"
    end

    it "maps #edit" do
      route_for(:controller => "usuario_sessions", :action => "edit", :id => "1").should == "/usuario_sessions/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "usuario_sessions", :action => "create").should == {:path => "/usuario_sessions", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "usuario_sessions", :action => "update", :id => "1").should == {:path =>"/usuario_sessions/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "usuario_sessions", :action => "destroy", :id => "1").should == {:path =>"/usuario_sessions/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/usuario_sessions").should == {:controller => "usuario_sessions", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/usuario_sessions/new").should == {:controller => "usuario_sessions", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/usuario_sessions").should == {:controller => "usuario_sessions", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/usuario_sessions/1").should == {:controller => "usuario_sessions", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/usuario_sessions/1/edit").should == {:controller => "usuario_sessions", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/usuario_sessions/1").should == {:controller => "usuario_sessions", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/usuario_sessions/1").should == {:controller => "usuario_sessions", :action => "destroy", :id => "1"}
    end
  end
end
