require 'test_helper'

class TalksControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @talk = talks(:one)
    @call  = calls(:one)
    sign_in users(:rockstar)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:talks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create talk" do
    assert_difference('Talk.count') do
      post :create, talk: @talk.attributes.merge(call_ids: [@call.id])
    end
  end

  test "should redirect to talk_path after creating talk" do
    post :create, talk: @talk.attributes.merge(call_ids: [@call.id])
    assert_redirected_to talk_path(assigns(:talk))
  end

  test 'should not create a talk given an invalid request' do
    post :create, talk: {}
    assert_response 400
  end

  test 'should not create a talk given invalid attributes' do
    post :create, talk: { title: nil }.merge(call_ids: [@call.id])
    assert_response :success
    assert_template :new
  end

  test "should show talk" do
    get :show, id: @talk.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @talk.to_param
    assert_response :success
  end

  test "should update talk" do
    put :update, id: @talk.to_param, talk: @talk.attributes
    assert_redirected_to talk_path(assigns(:talk))
  end

  test 'should not update a talk given invalid attributes' do
    put :update, id: @talk.to_param, talk: { title: nil }
    assert_template :edit
  end

  test "should destroy talk" do
    assert_difference('Talk.count', -1) do
      delete :destroy, id: @talk.to_param
    end

    assert_redirected_to talks_path
  end
end
