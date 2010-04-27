require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SolicitantesController do

  before(:each) do
    login({}, { :roles => {'admin' => nil} })
  end

  def mock_solicitante(stubs={})
    @mock_solicitante ||= mock_model(Solicitante, stubs)
  end

  describe "GET index" do
    it "assigns all solicitantes as @solicitantes" do
      Solicitante.stub!(:all).with(:order => "nome ASC").and_return([mock_solicitante])
      get :index
      assigns[:solicitantes].should == [mock_solicitante]
    end
  end

  describe "GET show" do
    it "assigns the requested solicitante as @solicitante" do
      Solicitante.stub!(:find).with("5").and_return(mock_solicitante)
      get :show, :id => "5"
      assigns[:solicitante].should equal(mock_solicitante)
    end
  end

  describe "GET new" do
    it "assigns a new solicitante as @solicitante" do
      Solicitante.stub!(:new).and_return(mock_solicitante)
      get :new
      assigns[:solicitante].should equal(mock_solicitante)
    end
  end

  describe "GET edit" do
    it "assigns the requested solicitante as @solicitante" do
      Solicitante.stub!(:find).with("37").and_return(mock_solicitante)
      get :edit, :id => "37"
      assigns[:solicitante].should equal(mock_solicitante)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created solicitante as @solicitante" do
        Solicitante.stub!(:new).with({'these' => 'params'}).and_return(mock_solicitante(:save => true))
        post :create, :solicitante => {:these => 'params'}
        assigns[:solicitante].should equal(mock_solicitante)
      end

      it "redirects to the created solicitante" do
        Solicitante.stub!(:new).and_return(mock_solicitante(:save => true))
        post :create, :solicitante => {}
        response.should redirect_to(solicitante_url(mock_solicitante))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved solicitante as @solicitante" do
        Solicitante.stub!(:new).with({'these' => 'params'}).and_return(mock_solicitante(:save => false))
        post :create, :solicitante => {:these => 'params'}
        assigns[:solicitante].should equal(mock_solicitante)
      end

      it "re-renders the 'new' template" do
        Solicitante.stub!(:new).and_return(mock_solicitante(:save => false))
        post :create, :solicitante => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested solicitante" do
        Solicitante.should_receive(:find).with("37").and_return(mock_solicitante)
        mock_solicitante.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :solicitante => {:these => 'params'}
      end

      it "assigns the requested solicitante as @solicitante" do
        Solicitante.stub!(:find).and_return(mock_solicitante(:update_attributes => true))
        put :update, :id => "1"
        assigns[:solicitante].should equal(mock_solicitante)
      end

      it "redirects to the solicitante" do
        Solicitante.stub!(:find).and_return(mock_solicitante(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(solicitante_url(mock_solicitante))
      end
    end

    describe "with invalid params" do
      it "updates the requested solicitante" do
        Solicitante.should_receive(:find).with("37").and_return(mock_solicitante)
        mock_solicitante.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :solicitante => {:these => 'params'}
      end

      it "assigns the solicitante as @solicitante" do
        Solicitante.stub!(:find).and_return(mock_solicitante(:update_attributes => false))
        put :update, :id => "1"
        assigns[:solicitante].should equal(mock_solicitante)
      end

      it "re-renders the 'edit' template" do
        Solicitante.stub!(:find).and_return(mock_solicitante(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested solicitante" do
      Solicitante.should_receive(:find).with("37").and_return(mock_solicitante)
      mock_solicitante.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the solicitantes list" do
      Solicitante.stub!(:find).and_return(mock_solicitante(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(solicitantes_url)
    end
  end

end

