require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ViagensController do

  before(:each) do
    login({}, { :roles => {'admin' => nil} })
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

  describe "GET index" do
    it "assigns all viagens as @viagens" do
      Viagem.stub!(:find).with(:all, :conditions => "estado = '"+ Viagem::AGUARDANDO + "'", :order => "data_partida ASC").and_return([mock_viagem])
      get :index
      assigns[:viagens].should == [mock_viagem]
    end
  end

  describe "GET show" do
    it "assigns the requested viagem as @viagem" do
      Motorista.stub!(:find).with("10").and_return(mock_motorista)
      Veiculo.stub!(:find).with("1").and_return(mock_veiculo)
      Viagem.stub!(:find).with("37").and_return(mock_viagem(:motoristas => nil, :veiculo_id => "1"))
      get :show, :id => "37"
      assigns[:viagem].should equal(mock_viagem)
    end
  end

  describe "GET new" do
    it "assigns a new viagem as @viagem" do
      Viagem.stub!(:new).and_return(mock_viagem)
      get :new
      assigns[:viagem].should equal(mock_viagem)
    end
  end

#  describe "GET edit" do
#    it "assigns the requested viagem as @viagem" do
#      Viagem.stub!(:find).with("37").and_return(mock_viagem)
#      get :edit, :id => "37"
#      assigns[:viagem].should equal(mock_viagem)
#    end
#  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created viagem as @viagem" do
        Viagem.stub!(:new).with({'these' => 'params'}).and_return(mock_viagem(:save => true))
        post :create, :viagem => {:these => 'params'}
        assigns[:viagem].should equal(mock_viagem)
      end

      it "redirects to the created viagem" do
        Viagem.stub!(:new).and_return(mock_viagem(:save => true))
        post :create, :viagem => {}
        response.should redirect_to(viagem_url(mock_viagem))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved viagem as @viagem" do
        Viagem.stub!(:new).with({'these' => 'params'}).and_return(mock_viagem(:save => false))
        post :create, :viagem => {:these => 'params'}
        assigns[:viagem].should equal(mock_viagem)
      end

      it "re-renders the 'new' template" do
        Viagem.stub!(:new).and_return(mock_viagem(:save => false))
        post :create, :viagem => {}
        response.should render_template('new')
      end
    end

  end

#  describe "PUT update" do

#    describe "with valid params" do
#      it "updates the requested viagem" do
#        Viagem.should_receive(:find).with("37").and_return(mock_viagem)
#        mock_viagem.should_receive(:update_attributes).with({'these' => 'params'})
#        put :update, :id => "37", :viagem => {:these => 'params'}
#      end

#      it "assigns the requested viagem as @viagem" do
#        Viagem.stub!(:find).and_return(mock_viagem(:update_attributes => true))
#        put :update, :id => "1"
#        assigns[:viagem].should equal(mock_viagem)
#      end

#      it "redirects to the viagem" do
#        Viagem.stub!(:find).and_return(mock_viagem(:update_attributes => true))
#        put :update, :id => "1"
#        response.should redirect_to(viagem_url(mock_viagem))
#      end
#    end

#    describe "with invalid params" do
#      it "updates the requested viagem" do
#        Viagem.should_receive(:find).with("37").and_return(mock_viagem)
#        mock_viagem.should_receive(:update_attributes).with({'these' => 'params'})
#        put :update, :id => "37", :viagem => {:these => 'params'}
#      end

#      it "assigns the viagem as @viagem" do
#        Viagem.stub!(:find).and_return(mock_viagem(:update_attributes => false))
#        put :update, :id => "1"
#        assigns[:viagem].should equal(mock_viagem)
#      end

#      it "re-renders the 'edit' template" do
#        Viagem.stub!(:find).and_return(mock_viagem(:update_attributes => false))
#        put :update, :id => "1"
#        response.should render_template('edit')
#      end
#    end

#  end

  describe "DELETE destroy" do
    it "destroys the requested viagem" do
      Viagem.should_receive(:find).with("37").and_return(mock_viagem)
      mock_viagem.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the viagens list" do
      Viagem.stub!(:find).and_return(mock_viagem(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(viagens_url)
    end
  end

end

