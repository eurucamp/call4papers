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

end
