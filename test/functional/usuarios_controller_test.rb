# -*- encoding : utf-8 -*-
require 'test_helper'

class UsuariosControllerTest < ActionController::TestCase
  
  setup do
    @usuario = usuarios(:one)    
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usuario" do
    assert_difference('Usuario.count') do
      post :create, usuario: { email: "xpto1@xpto.com", nome: @usuario.nome, nome_login: "xpto1", password_digest: @usuario.password_digest }
    end

    assert_redirected_to root_path
  end

  test "should get edit" do
    ApplicationController.mock_login(@request, @usuario)

    get :edit, id: @usuario
    assert_response :success
  end

  test "should update usuario" do
    ApplicationController.mock_login(@request, @usuario)

    put :update, id: @usuario, usuario: { email: "xpto2@xpto.com", nome: @usuario.nome, nome_login: "xpto2", password_digest: @usuario.password_digest }
    assert_redirected_to root_path
    assert_equal "Seu perfil foi atualizado com sucesso!", flash[:notice]
  end

  test "should delete usuario" do
    ApplicationController.mock_login(@request, @usuario)

    assert_difference('Usuario.count', -1) do
      delete :destroy, id: @usuario
    end

    assert_nil @request.session
    assert_redirected_to new_sessions_path
    assert_equal "Seu perfil foi excluído com sucesso!", flash[:notice]
  end

end
