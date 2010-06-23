require 'spec_helper'

describe PrefixosController do

  before(:each) do
    login({}, { :roles => {'admin' => nil} })
  end

  def mock_prefixo(stubs={})
    @mock_prefixo ||= mock_model(Prefixo, stubs)
  end

  describe "GET index" do
    it "assigns all prefixos as @prefixos" do
      Prefixo.stub(:find).with(:all).and_return([mock_prefixo])
      get :index
      assigns[:prefixos].should == [mock_prefixo]
    end
  end

  describe "GET show" do
    it "assigns the requested prefixo as @prefixo" do
      Prefixo.stub(:find).with("37").and_return(mock_prefixo)
      get :show, :id => "37"
      assigns[:prefixo].should equal(mock_prefixo)
    end
  end

  describe "GET new" do
    it "assigns a new prefixo as @prefixo" do
      Prefixo.stub(:new).and_return(mock_prefixo)
      get :new
      assigns[:prefixo].should equal(mock_prefixo)
    end
  end

  describe "GET edit" do
    it "assigns the requested prefixo as @prefixo" do
      Prefixo.stub(:find).with("37").and_return(mock_prefixo)
      get :edit, :id => "37"
      assigns[:prefixo].should equal(mock_prefixo)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created prefixo as @prefixo" do
        Prefixo.stub(:new).with({'these' => 'params'}).and_return(mock_prefixo(:save => true))
        post :create, :prefixo => {:these => 'params'}
        assigns[:prefixo].should equal(mock_prefixo)
      end

      it "redirects to the created prefixo" do
        Prefixo.stub(:new).and_return(mock_prefixo(:save => true))
        post :create, :prefixo => {}
        response.should redirect_to(prefixo_url(mock_prefixo))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved prefixo as @prefixo" do
        Prefixo.stub(:new).with({'these' => 'params'}).and_return(mock_prefixo(:save => false))
        post :create, :prefixo => {:these => 'params'}
        assigns[:prefixo].should equal(mock_prefixo)
      end

      it "re-renders the 'new' template" do
        Prefixo.stub(:new).and_return(mock_prefixo(:save => false))
        post :create, :prefixo => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested prefixo" do
        Prefixo.should_receive(:find).with("37").and_return(mock_prefixo)
        mock_prefixo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :prefixo => {:these => 'params'}
      end

      it "assigns the requested prefixo as @prefixo" do
        Prefixo.stub(:find).and_return(mock_prefixo(:update_attributes => true))
        put :update, :id => "1"
        assigns[:prefixo].should equal(mock_prefixo)
      end

      it "redirects to the prefixo" do
        Prefixo.stub(:find).and_return(mock_prefixo(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(prefixo_url(mock_prefixo))
      end
    end

    describe "with invalid params" do
      it "updates the requested prefixo" do
        Prefixo.should_receive(:find).with("37").and_return(mock_prefixo)
        mock_prefixo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :prefixo => {:these => 'params'}
      end

      it "assigns the prefixo as @prefixo" do
        Prefixo.stub(:find).and_return(mock_prefixo(:update_attributes => false))
        put :update, :id => "1"
        assigns[:prefixo].should equal(mock_prefixo)
      end

      it "re-renders the 'edit' template" do
        Prefixo.stub(:find).and_return(mock_prefixo(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested prefixo" do
      Prefixo.should_receive(:find).with("37").and_return(mock_prefixo)
      mock_prefixo.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the prefixos list" do
      Prefixo.stub(:find).and_return(mock_prefixo(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(prefixos_url)
    end
  end

end

