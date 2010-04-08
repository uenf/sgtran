require 'spec_helper'

describe CentrosController do

  before(:each) do
    login({}, { :roles => {'admin' => nil} })
  end

  def mock_centro(stubs={})
    @mock_centro ||= mock_model(Centro, stubs)
  end

  describe "GET index" do
    it "assigns all centros as @centros" do
      Centro.stub(:find).with(:all).and_return([mock_centro])
      get :index
      assigns[:centros].should == [mock_centro]
    end
  end

  describe "GET show" do
    it "assigns the requested centro as @centro" do
      Centro.stub(:find).with("37").and_return(mock_centro)
      get :show, :id => "37"
      assigns[:centro].should equal(mock_centro)
    end
  end

  describe "GET new" do
    it "assigns a new centro as @centro" do
      Centro.stub(:new).and_return(mock_centro)
      get :new
      assigns[:centro].should equal(mock_centro)
    end
  end

  describe "GET edit" do
    it "assigns the requested centro as @centro" do
      Centro.stub(:find).with("37").and_return(mock_centro)
      get :edit, :id => "37"
      assigns[:centro].should equal(mock_centro)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created centro as @centro" do
        Centro.stub(:new).with({'these' => 'params'}).and_return(mock_centro(:save => true))
        post :create, :centro => {:these => 'params'}
        assigns[:centro].should equal(mock_centro)
      end

      it "redirects to the created centro" do
        Centro.stub(:new).and_return(mock_centro(:save => true))
        post :create, :centro => {}
        response.should redirect_to(centro_url(mock_centro))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved centro as @centro" do
        Centro.stub(:new).with({'these' => 'params'}).and_return(mock_centro(:save => false))
        post :create, :centro => {:these => 'params'}
        assigns[:centro].should equal(mock_centro)
      end

      it "re-renders the 'new' template" do
        Centro.stub(:new).and_return(mock_centro(:save => false))
        post :create, :centro => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested centro" do
        Centro.should_receive(:find).with("37").and_return(mock_centro)
        mock_centro.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :centro => {:these => 'params'}
      end

      it "assigns the requested centro as @centro" do
        Centro.stub(:find).and_return(mock_centro(:update_attributes => true))
        put :update, :id => "1"
        assigns[:centro].should equal(mock_centro)
      end

      it "redirects to the centro" do
        Centro.stub(:find).and_return(mock_centro(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(centro_url(mock_centro))
      end
    end

    describe "with invalid params" do
      it "updates the requested centro" do
        Centro.should_receive(:find).with("37").and_return(mock_centro)
        mock_centro.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :centro => {:these => 'params'}
      end

      it "assigns the centro as @centro" do
        Centro.stub(:find).and_return(mock_centro(:update_attributes => false))
        put :update, :id => "1"
        assigns[:centro].should equal(mock_centro)
      end

      it "re-renders the 'edit' template" do
        Centro.stub(:find).and_return(mock_centro(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested centro" do
      Centro.should_receive(:find).with("37").and_return(mock_centro)
      mock_centro.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the centros list" do
      Centro.stub(:find).and_return(mock_centro(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(centros_url)
    end
  end

end

