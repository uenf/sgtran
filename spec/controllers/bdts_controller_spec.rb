require 'spec_helper'

describe BdtsController do

  before(:each) do
    login({}, { :roles => {'admin' => nil} })
  end

  def mock_bdt(stubs={})
    @mock_bdt ||= mock_model(Bdt, stubs)
  end

  def mock_viagem(stubs={})
    @mock_viagem ||= mock_model(Viagem, stubs)
  end

  def mock_motorista(stubs={})
    @mock_motorista ||= mock_model(Motorista, stubs)
  end

  def mock_veiculo(stubs={})
    @mock_veiculo ||= mock_model(Veiculo, stubs)
  end

  def stub_viagem
    Viagem.stub(:find).and_return(stub(:requisicao_ids => [], :motorista_id => nil, :veiculo_id => nil))
    Motorista.stub :find
    Veiculo.stub :find
  end

  describe "GET index" do
    it "assigns all bdts as @bdts" do
      Bdt.stub(:find).with(:all).and_return([mock_bdt])
      get :index
      assigns[:bdts].should == [mock_bdt]
    end
  end

  describe "GET show" do
    it "assigns the requested bdt as @bdt" do
      Bdt.stub(:find).with("37").and_return(
        mock_bdt(:viagem_id => nil))
      stub_viagem
      get :show, :id => "37", :viagem_id => 1
      assigns[:bdt].should equal(mock_bdt)
    end
  end

  describe "GET new" do
    it "assigns a new bdt as @bdt" do
      Viagem.should_receive(:find).with("37").and_return(mock_viagem(:requisicao_ids => [], :motorista_id => nil, :veiculo_id => nil))
      Motorista.should_receive(:find).with(nil).and_return(mock_motorista)
      Veiculo.should_receive(:find).with(nil).and_return(mock_veiculo)
      Bdt.stub(:new).and_return(mock_bdt)
      get :new, :id => "37"
      assigns[:viagem].should equal(mock_viagem(:motorista_id => nil, :veiculo_id => nil))
      assigns[:motorista].should equal(mock_motorista)
      assigns[:veiculo].should equal(mock_veiculo)
      assigns[:bdt].should equal(mock_bdt)
    end
  end

  describe "GET edit" do
    it "assigns the requested bdt as @bdt" do
      Bdt.stub(:find).with("37").and_return(mock_bdt(:viagem_id => nil))
      stub_viagem
      get :edit, :id => "37", :viagem => {}, :veiculo => {}, :motorista => {}
      assigns[:bdt].should equal(mock_bdt)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created bdt as @bdt" do
        Bdt.stub(:new).with({'these' => 'params'}).and_return(mock_bdt(:salvar => true))
        stub_viagem
        post :create, :bdt => {:these => 'params'}, :veiculo => {}, :motorista => {}, :viagem_id => 1, :cidade_origem => {}, :cidade_destino => {}
        assigns[:bdt].should equal(mock_bdt)
      end

      it "redirects to the created bdt" do
        Bdt.stub(:new).and_return(mock_bdt(:salvar => true))
        stub_viagem
        post :create, :bdt => {}, :veiculo => {}, :motorista => {}, :viagem_id => nil, :cidade_origem => {}, :cidade_destino => {}
        response.should redirect_to(bdt_url(mock_bdt))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bdt as @bdt" do
        Bdt.stub(:new).with({'these' => 'params'}).and_return(mock_bdt(:salvar => false))
        stub_viagem()
        post :create, :bdt => {:these => 'params'}, :veiculo => {}, :motorista => {}, :viagem_id => 1, :cidade_origem => {}, :cidade_destino => {}
        assigns[:bdt].should equal(mock_bdt)
      end

#      it "re-renders the 'new' template" do
#          Bdt.stub(:new).and_return(mock_bdt(:salvar => false))
#        post :create, :bdt => {}, :veiculo => {}, :motorista => {}, :viagem_id => nil
#        response.should render_template('new')
#      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested bdt" do
          Bdt.should_receive(:find).with("37").and_return(mock_bdt)
        mock_bdt.should_receive(:atualizar).with({"these" => "params"}, {:veiculo_id => nil, :motorista_id => nil, :viagem_id => nil})
        put :update, :id => "37", :bdt => {"these" => "params"}, :veiculo => {}, :motorista => {}, :viagem_id => nil, :cidade_origem => {}, :cidade_destino => {}
      end

      it "assigns the requested bdt as @bdt" do
        Bdt.stub(:find).and_return(mock_bdt(:atualizar => true))
        put :update, :id => "1", :veiculo => { :id => nil }, :motorista => { :id => nil }, :viagem_id => nil, :cidade_origem => {}, :cidade_destino => {}
        assigns[:bdt].should equal(mock_bdt)
      end

      it "redirects to the bdt" do
        Bdt.stub(:find).and_return(mock_bdt(:atualizar => true))
        put :update, :id => "1", :veiculo => { :id => nil }, :motorista => { :id => nil }, :viagem_id => nil, :cidade_origem => {}, :cidade_destino => {}
        response.should redirect_to(bdt_url(mock_bdt))
      end
    end

    describe "with invalid params" do
      it "updates the requested bdt" do
        Bdt.should_receive(:find).with("37").and_return(mock_bdt)
        mock_bdt.should_receive(:atualizar).with({'these' => 'params'}, {:veiculo_id => nil, :motorista_id => nil, :viagem_id => nil})
        put :update, :id => "37", :bdt => {:these => 'params'}, :veiculo => {}, :motorista => {}, :viagem_id => nil, :cidade_origem => {}, :cidade_destino => {}
      end

      it "assigns the bdt as @bdt" do
        Bdt.stub(:find).and_return(mock_bdt(:atualizar => false))
        put :update, :id => "1", :veiculo => { :id => nil }, :motorista => { :id => nil }, :viagem_id => nil, :cidade_origem => {}, :cidade_destino => {}
        assigns[:bdt].should equal(mock_bdt)
      end

      it "re-renders the 'edit' template" do
        Bdt.stub(:find).and_return(mock_bdt(:atualizar => false))
        put :update, :id => "1", :veiculo => { :id => nil }, :motorista => { :id => nil }, :viagem_id => nil, :cidade_origem => {}, :cidade_destino => {}
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested bdt" do
      Bdt.should_receive(:find).with("37").and_return(mock_bdt)
      mock_bdt.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the bdts list" do
      Bdt.stub(:find).and_return(mock_bdt(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(bdts_url)
    end
  end

end

