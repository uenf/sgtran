require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CombustiveisController do

  before(:each) do
    login({}, { :roles => {'admin' => nil} })
  end

  def mock_combustivel(stubs={})
    @mock_combustivel ||= mock_model(Combustivel, stubs)
  end

  describe "GET index" do
    it "assigns all combustiveis as @combustiveis" do
      Combustivel.stub!(:find).with(:all).and_return([mock_combustivel])
      get :index
      assigns[:combustiveis].should == [mock_combustivel]
    end
  end

  describe "GET show" do
    it "assigns the requested combustivel as @combustivel" do
      Combustivel.stub!(:find).with("37").and_return(mock_combustivel)
      get :show, :id => "37"
      assigns[:combustivel].should equal(mock_combustivel)
    end
  end

  describe "GET new" do
    it "assigns a new combustivel as @combustivel" do
      Combustivel.stub!(:new).and_return(mock_combustivel)
      get :new
      assigns[:combustivel].should equal(mock_combustivel)
    end
  end

  describe "GET edit" do
    it "assigns the requested combustivel as @combustivel" do
      Combustivel.stub!(:find).with("37").and_return(mock_combustivel)
      get :edit, :id => "37"
      assigns[:combustivel].should equal(mock_combustivel)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created combustivel as @combustivel" do
        Combustivel.stub!(:new).with({'these' => 'params'}).and_return(mock_combustivel(:save => true))
        post :create, :combustivel => {:these => 'params'}
        assigns[:combustivel].should equal(mock_combustivel)
      end

      it "redirects to the created combustivel" do
        Combustivel.stub!(:new).and_return(mock_combustivel(:save => true))
        post :create, :combustivel => {}
        response.should redirect_to(combustivel_url(mock_combustivel))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved combustivel as @combustivel" do
        Combustivel.stub!(:new).with({'these' => 'params'}).and_return(mock_combustivel(:save => false))
        post :create, :combustivel => {:these => 'params'}
        assigns[:combustivel].should equal(mock_combustivel)
      end

      it "re-renders the 'new' template" do
        Combustivel.stub!(:new).and_return(mock_combustivel(:save => false))
        post :create, :combustivel => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested combustivel" do
        Combustivel.should_receive(:find).with("37").and_return(mock_combustivel)
        mock_combustivel.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :combustivel => {:these => 'params'}
      end

      it "assigns the requested combustivel as @combustivel" do
        Combustivel.stub!(:find).and_return(mock_combustivel(:update_attributes => true))
        put :update, :id => "1"
        assigns[:combustivel].should equal(mock_combustivel)
      end

      it "redirects to the combustivel" do
        Combustivel.stub!(:find).and_return(mock_combustivel(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(combustivel_url(mock_combustivel))
      end
    end

    describe "with invalid params" do
      it "updates the requested combustivel" do
        Combustivel.should_receive(:find).with("37").and_return(mock_combustivel)
        mock_combustivel.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :combustivel => {:these => 'params'}
      end

      it "assigns the combustivel as @combustivel" do
        Combustivel.stub!(:find).and_return(mock_combustivel(:update_attributes => false))
        put :update, :id => "1"
        assigns[:combustivel].should equal(mock_combustivel)
      end

      it "re-renders the 'edit' template" do
        Combustivel.stub!(:find).and_return(mock_combustivel(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested combustivel" do
      Combustivel.should_receive(:find).with("37").and_return(mock_combustivel)
      mock_combustivel.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the combustiveis list" do
      Combustivel.stub!(:find).and_return(mock_combustivel(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(combustiveis_url)
    end
  end

end

