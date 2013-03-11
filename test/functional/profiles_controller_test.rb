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

  test 'should not update profile given an invalid request' do
    put :update, user: {}
    assert_response 400
  end

  test 'should not update profile given an invalid user' do
    put :update, user: { name: nil }
    assert_template :edit
  end

  test 'should update a profile given a valid user' do
    put :update, user: { name: 'New Name' }
    assert_redirected_to profile_path
  end

end
