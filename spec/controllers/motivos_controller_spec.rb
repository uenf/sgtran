require 'spec_helper'

describe MotivosController do

  def mock_motivo(stubs={})
    @mock_motivo ||= mock_model(Motivo, stubs)
  end

  describe "GET index" do
    it "assigns all motivos as @motivos" do
      Motivo.stub(:find).with(:all).and_return([mock_motivo])
      get :index
      assigns[:motivos].should == [mock_motivo]
    end
  end

  describe "GET show" do
    it "assigns the requested motivo as @motivo" do
      Motivo.stub(:find).with("37").and_return(mock_motivo)
      get :show, :id => "37"
      assigns[:motivo].should equal(mock_motivo)
    end
  end

  describe "GET new" do
    it "assigns a new motivo as @motivo" do
      Motivo.stub(:new).and_return(mock_motivo)
      get :new
      assigns[:motivo].should equal(mock_motivo)
    end
  end

  describe "GET edit" do
    it "assigns the requested motivo as @motivo" do
      Motivo.stub(:find).with("37").and_return(mock_motivo)
      get :edit, :id => "37"
      assigns[:motivo].should equal(mock_motivo)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created motivo as @motivo" do
        Motivo.stub(:new).with({'these' => 'params'}).and_return(mock_motivo(:save => true))
        post :create, :motivo => {:these => 'params'}
        assigns[:motivo].should equal(mock_motivo)
      end

      it "redirects to the created motivo" do
        Motivo.stub(:new).and_return(mock_motivo(:save => true))
        post :create, :motivo => {}
        response.should redirect_to(motivo_url(mock_motivo))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved motivo as @motivo" do
        Motivo.stub(:new).with({'these' => 'params'}).and_return(mock_motivo(:save => false))
        post :create, :motivo => {:these => 'params'}
        assigns[:motivo].should equal(mock_motivo)
      end

      it "re-renders the 'new' template" do
        Motivo.stub(:new).and_return(mock_motivo(:save => false))
        post :create, :motivo => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested motivo" do
        Motivo.should_receive(:find).with("37").and_return(mock_motivo)
        mock_motivo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :motivo => {:these => 'params'}
      end

      it "assigns the requested motivo as @motivo" do
        Motivo.stub(:find).and_return(mock_motivo(:update_attributes => true))
        put :update, :id => "1"
        assigns[:motivo].should equal(mock_motivo)
      end

      it "redirects to the motivo" do
        Motivo.stub(:find).and_return(mock_motivo(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(motivo_url(mock_motivo))
      end
    end

    describe "with invalid params" do
      it "updates the requested motivo" do
        Motivo.should_receive(:find).with("37").and_return(mock_motivo)
        mock_motivo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :motivo => {:these => 'params'}
      end

      it "assigns the motivo as @motivo" do
        Motivo.stub(:find).and_return(mock_motivo(:update_attributes => false))
        put :update, :id => "1"
        assigns[:motivo].should equal(mock_motivo)
      end

      it "re-renders the 'edit' template" do
        Motivo.stub(:find).and_return(mock_motivo(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested motivo" do
      Motivo.should_receive(:find).with("37").and_return(mock_motivo)
      mock_motivo.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the motivos list" do
      Motivo.stub(:find).and_return(mock_motivo(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(motivos_url)
    end
  end

end
