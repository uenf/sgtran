require 'spec_helper'

describe PrediosController do

  before(:each) do
    login({}, { :roles => {'admin' => nil} })
  end

  def mock_predio(stubs={})
    @mock_predio ||= mock_model(Predio, stubs)
  end

  describe "GET index" do
    it "assigns all predios as @predios" do
      Predio.stub(:find).with(:all).and_return([mock_predio])
      get :index
      assigns[:predios].should == [mock_predio]
    end
  end

  describe "GET show" do
    it "assigns the requested predio as @predio" do
      Predio.stub(:find).with("37").and_return(mock_predio)
      get :show, :id => "37"
      assigns[:predio].should equal(mock_predio)
    end
  end

  describe "GET new" do
    it "assigns a new predio as @predio" do
      Predio.stub(:new).and_return(mock_predio)
      get :new
      assigns[:predio].should equal(mock_predio)
    end
  end

  describe "GET edit" do
    it "assigns the requested predio as @predio" do
      Predio.stub(:find).with("37").and_return(mock_predio)
      get :edit, :id => "37"
      assigns[:predio].should equal(mock_predio)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created predio as @predio" do
        Predio.stub(:new).with({'these' => 'params'}).and_return(mock_predio(:save => true))
        post :create, :predio => {:these => 'params'}
        assigns[:predio].should equal(mock_predio)
      end

      it "redirects to the created predio" do
        Predio.stub(:new).and_return(mock_predio(:save => true))
        post :create, :predio => {}
        response.should redirect_to(predio_url(mock_predio))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved predio as @predio" do
        Predio.stub(:new).with({'these' => 'params'}).and_return(mock_predio(:save => false))
        post :create, :predio => {:these => 'params'}
        assigns[:predio].should equal(mock_predio)
      end

      it "re-renders the 'new' template" do
        Predio.stub(:new).and_return(mock_predio(:save => false))
        post :create, :predio => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested predio" do
        Predio.should_receive(:find).with("37").and_return(mock_predio)
        mock_predio.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :predio => {:these => 'params'}
      end

      it "assigns the requested predio as @predio" do
        Predio.stub(:find).and_return(mock_predio(:update_attributes => true))
        put :update, :id => "1"
        assigns[:predio].should equal(mock_predio)
      end

      it "redirects to the predio" do
        Predio.stub(:find).and_return(mock_predio(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(predio_url(mock_predio))
      end
    end

    describe "with invalid params" do
      it "updates the requested predio" do
        Predio.should_receive(:find).with("37").and_return(mock_predio)
        mock_predio.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :predio => {:these => 'params'}
      end

      it "assigns the predio as @predio" do
        Predio.stub(:find).and_return(mock_predio(:update_attributes => false))
        put :update, :id => "1"
        assigns[:predio].should equal(mock_predio)
      end

      it "re-renders the 'edit' template" do
        Predio.stub(:find).and_return(mock_predio(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested predio" do
      Predio.should_receive(:find).with("37").and_return(mock_predio)
      mock_predio.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the predios list" do
      Predio.stub(:find).and_return(mock_predio(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(predios_url)
    end
  end

end

