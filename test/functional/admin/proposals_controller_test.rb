require 'test_helper'

class Admin::ProposalsControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @call = calls(:one)
  end

  test 'should get index' do
    sign_in users(:admin_user)

    get :index, call_id: @call.id
    assert_response :success
  end

  test 'should get export (CSV)' do
    sign_in users(:admin_user)

    get :export, format: 'csv'
    assert_response :success

    csv = CSV.parse(response.body, headers: true)
    assert_equal 'Id',    csv.headers[0]
    assert_equal 'User name', csv.headers[1]
    assert_equal Proposal.count,       csv.size
  end

  test 'should accept talk selection from admin user' do
    sign_in users(:admin_user)

    post :update, id: 2, proposal: { selected: true }
    assert_response :redirect

    assert Proposal.find(2).selected
  end

  test 'should not accept any further parameters' do
    sign_in users(:admin_user)
    
    post :update, id: 2, proposal: { selected: true, user_id: 200 }

    assert_not_equal 200, Proposal.find(2).user_id
  end
end
