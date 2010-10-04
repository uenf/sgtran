require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RequisicoesController do

  before(:each) do
    login({}, { :roles => {'admin' => nil} })
  end

  def mock_requisicao(stubs={})
    @mock_requisicao ||= mock_model(Requisicao, stubs)
  end

  def mock_solicitante(stubs={})
    @mock_solicitante ||= mock_model(Solicitante, stubs)
  end

  describe "GET index" do
    it "assigns all requisicoes as @requisicoes" do
      Requisicao.stub!(:find).with(:all, :conditions => "estado = '"+ Requisicao::ESPERA + "'", :order => "id ASC").and_return([mock_requisicao])
      get :index
      assigns[:requisicoes].should == [mock_requisicao]
    end
  end

  describe "GET show" do
    it "assigns the requested requisicao as @requisicao" do
      Solicitante.stub(:find).with("12").and_return(mock_solicitante)
      Requisicao.stub(:find).with("37").and_return(mock_requisicao(:solicitante => nil))
      get :show, :id => "37"
      assigns[:requisicao].should equal(mock_requisicao)
    end
  end

  describe "GET new" do
    it "assigns a new requisicao as @requisicao" do
      Requisicao.stub!(:new).and_return(mock_requisicao)
      get :new
      assigns[:requisicao].should equal(mock_requisicao)
    end
  end

end

