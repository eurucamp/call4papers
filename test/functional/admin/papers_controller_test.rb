require 'test_helper'

class Admin::PapersControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  test 'should get index' do
    sign_in users(:admin_user)

    get :index
    assert_response :success
  end
end
