require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["omniauth.auth"]  = OmniAuth.config.mock_auth[:twitter]
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should create authentication" do
    post :create
    assert_redirected_to new_user_registration_url
  end

  # test "should destroy authentication" do
  #   sign_in users(:rockstar)
  #
  #   assert_difference('Authentication.count', -1) do
  #     delete :destroy #, id: @authentication.to_param
  #   end
  #
  #   assert_redirected_to authentications_path
  # end
end
