# -*- encoding : utf-8 -*-
require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase
  test "should get forgot" do
    get :forgot
    assert_response :success
  end

  test "should get reset" do
    get :reset
    assert_response :success
  end

end
