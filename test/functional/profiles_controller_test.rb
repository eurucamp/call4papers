require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in users(:rockstar)
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should update profile" do
    put :update
    assert_redirected_to profile_path
  end

end
