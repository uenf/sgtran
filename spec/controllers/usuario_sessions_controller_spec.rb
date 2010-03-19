require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsuarioSessionsController do

  before(:each) do
    login({}, { :roles => {'admin' => nil} })
  end

  def mock_usuario_session(stubs={})
    @mock_usuario_session ||= mock_model(UsuarioSession, stubs)
  end

  describe "GET new" do
    logout
    it "assigns a new usuario_session as @usuario_session" do
      logout()
      UsuarioSession.stub!(:new).and_return(mock_usuario_session)
      get :new
      #assigns[:usuario_session].should == mock_usuario_session
      response.should redirect_to(requisicoes_path)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created usuario_session as @usuario_session" do
        UsuarioSession.stub!(:new).with({'these' => 'params'}).and_return(mock_usuario_session(:save => true))
        post :create, :usuario_session => {:these => 'params'}
        #assigns[:usuario_session].should equal(mock_usuario_session)
        response.should render_template("erros/acesso_negado")
      end

      it "redirects to the created usuario_session" do
        UsuarioSession.stub!(:new).and_return(mock_usuario_session(:save => true))
        post :create, :usuario_session => {}
        response.should render_template("erros/acesso_negado")
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved usuario_session as @usuario_session" do

        UsuarioSession.stub!(:new).with({'these' => 'params'}).and_return(mock_usuario_session(:save => false))
        post :create, :usuario_session => {:these => 'params'}
        response.should render_template("erros/acesso_negado")
      end

      it "re-renders the 'new' template" do
        UsuarioSession.stub!(:new).and_return(mock_usuario_session(:save => false))
        post :create, :usuario_session => {}
        response.should render_template("erros/acesso_negado")
      end
    end

  end


  describe "DELETE destroy" do

    it "redirects to the usuario_sessions list" do
      UsuarioSession.stub!(:find).and_return(mock_usuario_session(:destroy => true, :record => nil))
      delete :destroy, :id => "1"
      response.should redirect_to(new_requisicao_path)
    end
  end

end

