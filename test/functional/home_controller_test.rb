# -*- encoding : utf-8 -*-
require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_redirected_to new_sessions_path
  end

end
