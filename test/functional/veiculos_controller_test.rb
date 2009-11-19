require 'test_helper'

class VeiculosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:veiculos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create veiculo" do
    assert_difference('Veiculo.count') do
      post :create, :veiculo => { }
    end

    assert_redirected_to veiculo_path(assigns(:veiculo))
  end

  test "should show veiculo" do
    get :show, :id => veiculos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => veiculos(:one).to_param
    assert_response :success
  end

  test "should update veiculo" do
    put :update, :id => veiculos(:one).to_param, :veiculo => { }
    assert_redirected_to veiculo_path(assigns(:veiculo))
  end

  test "should destroy veiculo" do
    assert_difference('Veiculo.count', -1) do
      delete :destroy, :id => veiculos(:one).to_param
    end

    assert_redirected_to veiculos_path
  end
end
