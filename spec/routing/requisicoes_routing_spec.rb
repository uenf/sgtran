require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RequisicoesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "requisicoes", :action => "index").should == "/requisicoes"
    end

    it "maps #new" do
      route_for(:controller => "requisicoes", :action => "new").should == "/requisicoes/new" or "/"
    end

    it "maps #cancelar_requisicao" do
      route_for(:controller => "requisicoes", :action => "cancelar_requisicao", :id => "2", :chave_de_seguranca => "5088ad26f42e13383445fa6952818489bef60bb9").should == "/requisicoes/cancelar/2/5088ad26f42e13383445fa6952818489bef60bb9"
    end

  end

  describe "route recognition" do

    it "generates params for #edit" do
      params_from(:get, "/requisicoes/cancelar/2/5088ad26f42e13383445fa6952818489bef60bb9").should == {:controller => "requisicoes", :action => "cancelar_requisicao", :id => "2", :chave_de_seguranca => "5088ad26f42e13383445fa6952818489bef60bb9"}
    end
  end
end

