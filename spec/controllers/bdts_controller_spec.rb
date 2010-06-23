require 'spec_helper'

describe BdtsController do

  def mock_bdt(stubs={})
    @mock_bdt ||= mock_model(Bdt, stubs)
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
      Bdt.stub(:find).with("37").and_return(mock_bdt)
      get :show, :id => "37"
      assigns[:bdt].should equal(mock_bdt)
    end
  end

  describe "GET new" do
    it "assigns a new bdt as @bdt" do
      Bdt.stub(:new).and_return(mock_bdt)
      get :new
      assigns[:bdt].should equal(mock_bdt)
    end
  end

  describe "GET edit" do
    it "assigns the requested bdt as @bdt" do
      Bdt.stub(:find).with("37").and_return(mock_bdt)
      get :edit, :id => "37"
      assigns[:bdt].should equal(mock_bdt)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created bdt as @bdt" do
        Bdt.stub(:new).with({'these' => 'params'}).and_return(mock_bdt(:save => true))
        post :create, :bdt => {:these => 'params'}
        assigns[:bdt].should equal(mock_bdt)
      end

      it "redirects to the created bdt" do
        Bdt.stub(:new).and_return(mock_bdt(:save => true))
        post :create, :bdt => {}
        response.should redirect_to(bdt_url(mock_bdt))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bdt as @bdt" do
        Bdt.stub(:new).with({'these' => 'params'}).and_return(mock_bdt(:save => false))
        post :create, :bdt => {:these => 'params'}
        assigns[:bdt].should equal(mock_bdt)
      end

      it "re-renders the 'new' template" do
        Bdt.stub(:new).and_return(mock_bdt(:save => false))
        post :create, :bdt => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested bdt" do
        Bdt.should_receive(:find).with("37").and_return(mock_bdt)
        mock_bdt.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :bdt => {:these => 'params'}
      end

      it "assigns the requested bdt as @bdt" do
        Bdt.stub(:find).and_return(mock_bdt(:update_attributes => true))
        put :update, :id => "1"
        assigns[:bdt].should equal(mock_bdt)
      end

      it "redirects to the bdt" do
        Bdt.stub(:find).and_return(mock_bdt(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(bdt_url(mock_bdt))
      end
    end

    describe "with invalid params" do
      it "updates the requested bdt" do
        Bdt.should_receive(:find).with("37").and_return(mock_bdt)
        mock_bdt.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :bdt => {:these => 'params'}
      end

      it "assigns the bdt as @bdt" do
        Bdt.stub(:find).and_return(mock_bdt(:update_attributes => false))
        put :update, :id => "1"
        assigns[:bdt].should equal(mock_bdt)
      end

      it "re-renders the 'edit' template" do
        Bdt.stub(:find).and_return(mock_bdt(:update_attributes => false))
        put :update, :id => "1"
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
