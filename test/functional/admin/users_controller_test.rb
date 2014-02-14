require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  test 'should get index' do
    sign_in users(:admin_user)

    get :index
    assert_response :success
  end

  test 'should get export (CSV)' do
    sign_in users(:admin_user)

    get :export, format: 'csv'
    assert_response :success

    csv = CSV.parse(response.body, headers: true)
    assert_equal 'id',    csv.headers[0]
    assert_equal 'name',  csv.headers[1]
    assert_equal 3,       csv.size
  end
end
