require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CategoriaDeVeiculosController do

  before(:each) do
    login({}, { :roles => {'admin' => nil} })
  end

  def mock_categoria_de_veiculo(stubs={})
    @mock_categoria_de_veiculo ||= mock_model(CategoriaDeVeiculo, stubs)
  end

  describe "GET index" do
    it "assigns all categoria_de_veiculos as @categoria_de_veiculos" do
      CategoriaDeVeiculo.stub!(:find).with(:all).and_return([mock_categoria_de_veiculo])
      get :index
      assigns[:categoria_de_veiculos].should == [mock_categoria_de_veiculo]
    end
  end

  describe "GET show" do
    it "assigns the requested categoria_de_veiculo as @categoria_de_veiculo" do
      CategoriaDeVeiculo.stub!(:find).with("37").and_return(mock_categoria_de_veiculo)
      get :show, :id => "37"
      assigns[:categoria_de_veiculo].should equal(mock_categoria_de_veiculo)
    end
  end

  describe "GET new" do
    it "assigns a new categoria_de_veiculo as @categoria_de_veiculo" do
      CategoriaDeVeiculo.stub!(:new).and_return(mock_categoria_de_veiculo)
      get :new
      assigns[:categoria_de_veiculo].should equal(mock_categoria_de_veiculo)
    end
  end

  describe "GET edit" do
    it "assigns the requested categoria_de_veiculo as @categoria_de_veiculo" do
      CategoriaDeVeiculo.stub!(:find).with("37").and_return(mock_categoria_de_veiculo)
      get :edit, :id => "37"
      assigns[:categoria_de_veiculo].should equal(mock_categoria_de_veiculo)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created categoria_de_veiculo as @categoria_de_veiculo" do
        CategoriaDeVeiculo.stub!(:new).with({'these' => 'params'}).and_return(mock_categoria_de_veiculo(:save => true))
        post :create, :categoria_de_veiculo => {:these => 'params'}
        assigns[:categoria_de_veiculo].should equal(mock_categoria_de_veiculo)
      end

      it "redirects to the created categoria_de_veiculo" do
        CategoriaDeVeiculo.stub!(:new).and_return(mock_categoria_de_veiculo(:save => true))
        post :create, :categoria_de_veiculo => {}
        response.should redirect_to(categoria_de_veiculo_url(mock_categoria_de_veiculo))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved categoria_de_veiculo as @categoria_de_veiculo" do
        CategoriaDeVeiculo.stub!(:new).with({'these' => 'params'}).and_return(mock_categoria_de_veiculo(:save => false))
        post :create, :categoria_de_veiculo => {:these => 'params'}
        assigns[:categoria_de_veiculo].should equal(mock_categoria_de_veiculo)
      end

      it "re-renders the 'new' template" do
        CategoriaDeVeiculo.stub!(:new).and_return(mock_categoria_de_veiculo(:save => false))
        post :create, :categoria_de_veiculo => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested categoria_de_veiculo" do
        CategoriaDeVeiculo.should_receive(:find).with("37").and_return(mock_categoria_de_veiculo)
        mock_categoria_de_veiculo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :categoria_de_veiculo => {:these => 'params'}
      end

      it "assigns the requested categoria_de_veiculo as @categoria_de_veiculo" do
        CategoriaDeVeiculo.stub!(:find).and_return(mock_categoria_de_veiculo(:update_attributes => true))
        put :update, :id => "1"
        assigns[:categoria_de_veiculo].should equal(mock_categoria_de_veiculo)
      end

      it "redirects to the categoria_de_veiculo" do
        CategoriaDeVeiculo.stub!(:find).and_return(mock_categoria_de_veiculo(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(categoria_de_veiculo_url(mock_categoria_de_veiculo))
      end
    end

    describe "with invalid params" do
      it "updates the requested categoria_de_veiculo" do
        CategoriaDeVeiculo.should_receive(:find).with("37").and_return(mock_categoria_de_veiculo)
        mock_categoria_de_veiculo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :categoria_de_veiculo => {:these => 'params'}
      end

      it "assigns the categoria_de_veiculo as @categoria_de_veiculo" do
        CategoriaDeVeiculo.stub!(:find).and_return(mock_categoria_de_veiculo(:update_attributes => false))
        put :update, :id => "1"
        assigns[:categoria_de_veiculo].should equal(mock_categoria_de_veiculo)
      end

      it "re-renders the 'edit' template" do
        CategoriaDeVeiculo.stub!(:find).and_return(mock_categoria_de_veiculo(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested categoria_de_veiculo" do
      CategoriaDeVeiculo.should_receive(:find).with("37").and_return(mock_categoria_de_veiculo)
      mock_categoria_de_veiculo.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the categoria_de_veiculos list" do
      CategoriaDeVeiculo.stub!(:find).and_return(mock_categoria_de_veiculo(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(categoria_de_veiculos_url)
    end
  end

end

