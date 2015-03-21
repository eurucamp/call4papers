require 'test_helper'

class ProposalsControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @talk = talks(:one)
    @call  = calls(:one)
    sign_in users(:rockstar)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proposals)
  end

  test "should get new" do
    get :new, call_id: @call.id
    assert_response :success
  end

  test "should create talk" do
    assert_difference('Proposal.count') do
      post :create, talk: @talk.attributes, call_id: @call.id
    end
  end

  test "should redirect to proposal_path after creating talk" do
    post :create, talk: @talk.attributes, call_id: @call.id
    assert_redirected_to proposal_path(assigns(:proposal))
  end

  test 'should not create a proposal given an invalid request' do
    post :create, proposal: {}, call_id: @call.id
    assert_response 400
  end

  test 'should not create a talk given invalid attributes' do
    post :create, talk: { title: nil }, call_id: @call.id
    assert_response :success
    assert_template :new
  end

  test "should show proposal" do
    get :show, id: @talk.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @talk.to_param
    assert_response :success
  end

  test "should update proposal" do
    put :update, id: @talk.to_param, talk: @talk.attributes
    assert_redirected_to proposal_path(assigns(:proposal))
  end

  test 'should not update a proposal given invalid attributes' do
    put :update, id: @talk.to_param, talk: { title: nil }
    assert_template :edit
  end

  test "should destroy proposal" do
    assert_difference('Proposal.count', -1) do
      delete :destroy, id: @talk.to_param
    end

    assert_redirected_to proposals_path
  end
end
