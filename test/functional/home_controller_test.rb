require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in users(:rockstar)
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should default to eurucamp as the conference" do
    get :show
    assert_equal 'eurucamp', assigns(:conference)
  end

  test "should set conference accordingly" do
    get :show, conference: 'jrubyconf'
    assert_equal 'jrubyconf', assigns(:conference)
  end

  test "should not set the variable to an unknown conference" do
    get :show, conference: 'unknownconf'
    assert_equal 'eurucamp', assigns(:conference)
  end
end
