require 'test_helper'

class ObjetivosDeReservaControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:objetivos_de_reserva)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create objetivo_de_reserva" do
    assert_difference('ObjetivoDeReserva.count') do
      post :create, :objetivo_de_reserva => { }
    end

    assert_redirected_to objetivo_de_reserva_path(assigns(:objetivo_de_reserva))
  end

  test "should show objetivo_de_reserva" do
    get :show, :id => objetivos_de_reserva(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => objetivos_de_reserva(:one).to_param
    assert_response :success
  end

  test "should update objetivo_de_reserva" do
    put :update, :id => objetivos_de_reserva(:one).to_param, :objetivo_de_reserva => { }
    assert_redirected_to objetivo_de_reserva_path(assigns(:objetivo_de_reserva))
  end

  test "should destroy objetivo_de_reserva" do
    assert_difference('ObjetivoDeReserva.count', -1) do
      delete :destroy, :id => objetivos_de_reserva(:one).to_param
    end

    assert_redirected_to objetivos_de_reserva_path
  end
end
