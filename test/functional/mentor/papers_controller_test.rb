require 'test_helper'

class Mentor::PapersControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  test 'should get index when user is mentor' do
    sign_in users(:mentor_user)

    get :index
    assert_response :success
  end

  test 'should not get index when user is not mentor' do
    sign_in users(:rockstar)

    get :index
    assert_redirected_to root_path
  end
end
