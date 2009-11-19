require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CategoriaDeVeiculosController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "categoria_de_veiculos", :action => "index").should == "/categoria_de_veiculos"
    end

    it "maps #new" do
      route_for(:controller => "categoria_de_veiculos", :action => "new").should == "/categoria_de_veiculos/new"
    end

    it "maps #show" do
      route_for(:controller => "categoria_de_veiculos", :action => "show", :id => "1").should == "/categoria_de_veiculos/1"
    end

    it "maps #edit" do
      route_for(:controller => "categoria_de_veiculos", :action => "edit", :id => "1").should == "/categoria_de_veiculos/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "categoria_de_veiculos", :action => "create").should == {:path => "/categoria_de_veiculos", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "categoria_de_veiculos", :action => "update", :id => "1").should == {:path =>"/categoria_de_veiculos/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "categoria_de_veiculos", :action => "destroy", :id => "1").should == {:path =>"/categoria_de_veiculos/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/categoria_de_veiculos").should == {:controller => "categoria_de_veiculos", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/categoria_de_veiculos/new").should == {:controller => "categoria_de_veiculos", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/categoria_de_veiculos").should == {:controller => "categoria_de_veiculos", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/categoria_de_veiculos/1").should == {:controller => "categoria_de_veiculos", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/categoria_de_veiculos/1/edit").should == {:controller => "categoria_de_veiculos", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/categoria_de_veiculos/1").should == {:controller => "categoria_de_veiculos", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/categoria_de_veiculos/1").should == {:controller => "categoria_de_veiculos", :action => "destroy", :id => "1"}
    end
  end
end
