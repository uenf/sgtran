require 'spec_helper'

describe EstadosController do

  def mock_estado(stubs={})
    @mock_estado ||= mock_model(Estado, stubs)
  end

  describe "GET index" do
    it "assigns all estados as @estados" do
      Estado.stub(:find).with(:all).and_return([mock_estado])
      get :index
      assigns[:estados].should == [mock_estado]
    end
  end

  describe "GET show" do
    it "assigns the requested estado as @estado" do
      Estado.stub(:find).with("37").and_return(mock_estado)
      get :show, :id => "37"
      assigns[:estado].should equal(mock_estado)
    end
  end

  describe "GET new" do
    it "assigns a new estado as @estado" do
      Estado.stub(:new).and_return(mock_estado)
      get :new
      assigns[:estado].should equal(mock_estado)
    end
  end

  describe "GET edit" do
    it "assigns the requested estado as @estado" do
      Estado.stub(:find).with("37").and_return(mock_estado)
      get :edit, :id => "37"
      assigns[:estado].should equal(mock_estado)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created estado as @estado" do
        Estado.stub(:new).with({'these' => 'params'}).and_return(mock_estado(:save => true))
        post :create, :estado => {:these => 'params'}
        assigns[:estado].should equal(mock_estado)
      end

      it "redirects to the created estado" do
        Estado.stub(:new).and_return(mock_estado(:save => true))
        post :create, :estado => {}
        response.should redirect_to(estado_url(mock_estado))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved estado as @estado" do
        Estado.stub(:new).with({'these' => 'params'}).and_return(mock_estado(:save => false))
        post :create, :estado => {:these => 'params'}
        assigns[:estado].should equal(mock_estado)
      end

      it "re-renders the 'new' template" do
        Estado.stub(:new).and_return(mock_estado(:save => false))
        post :create, :estado => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested estado" do
        Estado.should_receive(:find).with("37").and_return(mock_estado)
        mock_estado.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :estado => {:these => 'params'}
      end

      it "assigns the requested estado as @estado" do
        Estado.stub(:find).and_return(mock_estado(:update_attributes => true))
        put :update, :id => "1"
        assigns[:estado].should equal(mock_estado)
      end

      it "redirects to the estado" do
        Estado.stub(:find).and_return(mock_estado(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(estado_url(mock_estado))
      end
    end

    describe "with invalid params" do
      it "updates the requested estado" do
        Estado.should_receive(:find).with("37").and_return(mock_estado)
        mock_estado.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :estado => {:these => 'params'}
      end

      it "assigns the estado as @estado" do
        Estado.stub(:find).and_return(mock_estado(:update_attributes => false))
        put :update, :id => "1"
        assigns[:estado].should equal(mock_estado)
      end

      it "re-renders the 'edit' template" do
        Estado.stub(:find).and_return(mock_estado(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested estado" do
      Estado.should_receive(:find).with("37").and_return(mock_estado)
      mock_estado.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the estados list" do
      Estado.stub(:find).and_return(mock_estado(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(estados_url)
    end
  end

end
