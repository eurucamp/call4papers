require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test 'should redirect a user to register, if no authentication or incorrect details' do
    request.env['omniauth.auth'] = { 'provider' => 'none',  'uuid' => 'none',
                        'info' => {} }

    post :create
    assert_redirected_to new_user_registration_url
  end

  test 'should redirect a user to register, if no authnetication ' do
    request.env['omniauth.auth'] = { 'provider' => 'none',  'uuid' => 'none',
                        'info' => { 'email' => 'test@john.com', 'name' => 'test'} }

    post :create
    assert_redirected_to '/'
  end

  test 'should create authentication, for user already logged in' do
    request.env['omniauth.auth']  = { provider: 'none',  uuid: 'none' }
    request.env['HTTP_REFERER']   = 'http://backtoreality/'
    sign_in users(:rockstar)

    post :create
    assert_redirected_to 'http://backtoreality/'
  end

  test 'should create authentication when an existing authentication exists' do
    request.env['omniauth.auth']  = OmniAuth.config.mock_auth[:twitter]

    post :create
  end

  test "should destroy authentication" do
    @authentication = authentications(:two)
    sign_in @authentication.user

    assert_difference('Authentication.count', -1) do
      delete :destroy, id: @authentication.to_param
    end

    assert_redirected_to authentications_path
  end
end
