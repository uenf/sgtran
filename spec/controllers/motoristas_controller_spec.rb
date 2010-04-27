require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MotoristasController do

  before(:each) do
    login({}, { :roles => {'admin' => nil} })
  end

  def mock_motorista(stubs={})
    @mock_motorista ||= mock_model(Motorista, stubs)
  end

  describe "GET index" do
    it "assigns all motoristas as @motoristas" do
      Motorista.stub!(:all).with(:order => "nome ASC").and_return([mock_motorista])
      get :index
      assigns[:motoristas].should == [mock_motorista]
    end
  end

  describe "GET show" do
    it "assigns the requested motorista as @motorista" do
      Motorista.stub!(:find).with("37").and_return(mock_motorista)
      get :show, :id => "37"
      assigns[:motorista].should equal(mock_motorista)
    end
  end

  describe "GET new" do
    it "assigns a new motorista as @motorista" do
      Motorista.stub!(:new).and_return(mock_motorista)
      get :new
      assigns[:motorista].should equal(mock_motorista)
    end
  end

  describe "GET edit" do
    it "assigns the requested motorista as @motorista" do
      Motorista.stub!(:find).with("37").and_return(mock_motorista)
      get :edit, :id => "37"
      assigns[:motorista].should equal(mock_motorista)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created motorista as @motorista" do
        Motorista.stub!(:new).with({'these' => 'params'}).and_return(mock_motorista(:save => true))
        post :create, :motorista => {:these => 'params'}
        assigns[:motorista].should equal(mock_motorista)
      end

      it "redirects to the created motorista" do
        Motorista.stub!(:new).and_return(mock_motorista(:save => true))
        post :create, :motorista => {}
        response.should redirect_to(motorista_url(mock_motorista))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved motorista as @motorista" do
        Motorista.stub!(:new).with({'these' => 'params'}).and_return(mock_motorista(:save => false))
        post :create, :motorista => {:these => 'params'}
        assigns[:motorista].should equal(mock_motorista)
      end

      it "re-renders the 'new' template" do
        Motorista.stub!(:new).and_return(mock_motorista(:save => false))
        post :create, :motorista => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested motorista" do
        Motorista.should_receive(:find).with("37").and_return(mock_motorista)
        mock_motorista.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :motorista => {:these => 'params'}
      end

      it "assigns the requested motorista as @motorista" do
        Motorista.stub!(:find).and_return(mock_motorista(:update_attributes => true))
        put :update, :id => "1"
        assigns[:motorista].should equal(mock_motorista)
      end

      it "redirects to the motorista" do
        Motorista.stub!(:find).and_return(mock_motorista(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(motorista_url(mock_motorista))
      end
    end

    describe "with invalid params" do
      it "updates the requested motorista" do
        Motorista.should_receive(:find).with("37").and_return(mock_motorista)
        mock_motorista.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :motorista => {:these => 'params'}
      end

      it "assigns the motorista as @motorista" do
        Motorista.stub!(:find).and_return(mock_motorista(:update_attributes => false))
        put :update, :id => "1"
        assigns[:motorista].should equal(mock_motorista)
      end

      it "re-renders the 'edit' template" do
        Motorista.stub!(:find).and_return(mock_motorista(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested motorista" do
      Motorista.should_receive(:find).with("37").and_return(mock_motorista)
      mock_motorista.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the motoristas list" do
      Motorista.stub!(:find).and_return(mock_motorista(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(motoristas_url)
    end
  end

end

