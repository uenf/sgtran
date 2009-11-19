require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe VeiculosController do

  def mock_veiculo(stubs={})
    @mock_veiculo ||= mock_model(Veiculo, stubs)
  end

  def mock_categoria_de_veiculo(stubs={})
    @mock_categoria_de_veiculo ||= mock_model(CategoriaDeVeiculo, stubs)
  end

  describe "GET index" do
    it "assigns all veiculos as @veiculos" do
      Veiculo.stub!(:find).with(:all).and_return([mock_veiculo])
      get :index
      assigns[:veiculos].should == [mock_veiculo]
    end
  end

  describe "GET show" do
    it "assigns the requested veiculo as @veiculo" do
      CategoriaDeVeiculo.stub!(:find).with("10").and_return(mock_categoria_de_veiculo)
      Veiculo.stub!(:find).with("37").and_return(mock_veiculo(:categoria_de_veiculo_id => "10"))
      get :show, :id => "37"
      assigns[:veiculo].should equal(mock_veiculo)
    end
  end

  describe "GET new" do
    it "assigns a new veiculo as @veiculo" do
      Veiculo.stub!(:new).and_return(mock_veiculo)
      get :new
      assigns[:veiculo].should equal(mock_veiculo)
    end
  end

  describe "GET edit" do
    it "assigns the requested veiculo as @veiculo" do
      Veiculo.stub!(:find).with("37").and_return(mock_veiculo)
      get :edit, :id => "37"
      assigns[:veiculo].should equal(mock_veiculo)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created veiculo as @veiculo" do
        Veiculo.stub!(:new).with({'these' => 'params'}).and_return(mock_veiculo(:save => true))
        post :create, :veiculo => {:these => 'params'}
        assigns[:veiculo].should equal(mock_veiculo)
      end

      it "redirects to the created veiculo" do
        Veiculo.stub!(:new).and_return(mock_veiculo(:save => true))
        post :create, :veiculo => {}
        response.should redirect_to(veiculo_url(mock_veiculo))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved veiculo as @veiculo" do
        Veiculo.stub!(:new).with({'these' => 'params'}).and_return(mock_veiculo(:save => false))
        post :create, :veiculo => {:these => 'params'}
        assigns[:veiculo].should equal(mock_veiculo)
      end

      it "re-renders the 'new' template" do
        Veiculo.stub!(:new).and_return(mock_veiculo(:save => false))
        post :create, :veiculo => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested veiculo" do
        Veiculo.should_receive(:find).with("37").and_return(mock_veiculo)
        mock_veiculo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :veiculo => {:these => 'params'}
      end

      it "assigns the requested veiculo as @veiculo" do
        Veiculo.stub!(:find).and_return(mock_veiculo(:update_attributes => true))
        put :update, :id => "1"
        assigns[:veiculo].should equal(mock_veiculo)
      end

      it "redirects to the veiculo" do
        Veiculo.stub!(:find).and_return(mock_veiculo(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(veiculo_url(mock_veiculo))
      end
    end

    describe "with invalid params" do
      it "updates the requested veiculo" do
        Veiculo.should_receive(:find).with("37").and_return(mock_veiculo)
        mock_veiculo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :veiculo => {:these => 'params'}
      end

      it "assigns the veiculo as @veiculo" do
        Veiculo.stub!(:find).and_return(mock_veiculo(:update_attributes => false))
        put :update, :id => "1"
        assigns[:veiculo].should equal(mock_veiculo)
      end

      it "re-renders the 'edit' template" do
        Veiculo.stub!(:find).and_return(mock_veiculo(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested veiculo" do
      Veiculo.should_receive(:find).with("37").and_return(mock_veiculo)
      mock_veiculo.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the veiculos list" do
      Veiculo.stub!(:find).and_return(mock_veiculo(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(veiculos_url)
    end
  end

end

