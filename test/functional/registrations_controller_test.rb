require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  test "should not create an invalid registration" do
    post :create, { user: { name: 'Test user',  email: 'fishcakes2@fishcakes.com' }}
    assert_template :new
  end

  test "should create registration" do
    assert_difference('User.count') do
      post :create, { user: { name: 'Test user',  email: 'fishcakes@fishcakes.com', password: '123456789', password_confirmation: '123456789' }}
    end

    assert_redirected_to root_path
  end

end
