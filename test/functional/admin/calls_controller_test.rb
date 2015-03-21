require 'test_helper'

class Admin::CallsControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  test 'should get index' do
    sign_in users(:admin_user)
    get :index
    assert_response :success
    assert_not_nil assigns(:calls)
  end
end
