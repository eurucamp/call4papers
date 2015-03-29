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

  test 'should create talk and not fail with PG::UniqueViolation' do
    call_id = calls(:one).id.to_s
    post :create, talk: {
           "title"=>"asdfsfd",
           "public_description"=>"fasfsad",
           "private_description"=>"fasdfasf",
           "time_slot"=>"30 minutes",
           "mentor_name"=>"",
           "mentors_can_read"=>"1",
           "terms_and_conditions"=>"1",
           "user_attributes"=> {
             "gender"=>"",
             "mentor"=>"0",
             "bio"=>""
           },
           "call_ids"=> [call_id, ""]
         }
  end
end
