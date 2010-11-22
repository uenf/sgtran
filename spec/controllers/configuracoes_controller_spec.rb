require 'spec_helper'

describe ConfiguracoesController do

  before(:each) do
    login({}, { :roles => {'admin' => nil} })
  end

  def mock_configuracao(stubs={})
    @mock_configuracao ||= mock_model(Configuracao, stubs)
  end

#  describe "GET edit" do
#    it "assigns the requested configuracao as @configuracao" do
#      Configuracao.stub(:first).and_return(mock_configuracao)
#      get :edit, :id => "2"
#      assigns[:configuracao].should == mock_configuracao
#    end
#  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested configuracao" do
        Configuracao.should_receive(:find).with("37").and_return(mock_configuracao)
        mock_configuracao.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :configuracao => {:these => 'params'}
      end

      it "assigns the requested configuracao as @configuracao" do
        Configuracao.stub(:find).and_return(mock_configuracao(:update_attributes => true))
        put :update, :id => "1"
        assigns[:configuracao].should equal(mock_configuracao)
      end

      it "redirects to the configuracao" do
        Configuracao.stub(:find).and_return(mock_configuracao(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(edit_configuracao_url(mock_configuracao))
      end
    end

    describe "with invalid params" do
      it "updates the requested configuracao" do
        Configuracao.should_receive(:find).with("37").and_return(mock_configuracao)
        mock_configuracao.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :configuracao => {:these => 'params'}
      end

      it "assigns the configuracao as @configuracao" do
        Configuracao.stub(:find).and_return(mock_configuracao(:update_attributes => false))
        put :update, :id => "1"
        assigns[:configuracao].should equal(mock_configuracao)
      end

      it "re-renders the 'edit' template" do
        Configuracao.stub(:find).and_return(mock_configuracao(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

end

