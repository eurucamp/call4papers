require 'test_helper'

class PapersControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @paper = papers(:one)
    sign_in users(:rockstar)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:papers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paper" do
    assert_difference('Paper.count') do
      post :create, paper: @paper.attributes
    end

    assert_redirected_to paper_path(assigns(:paper))
  end

  test 'should not create a paper given an invalid request' do
    post :create, paper: {}
    assert_response 400
  end

  test 'should not create a paper given invalid attributes' do
    post :create, paper: { title: nil }
    assert_response :success
    assert_template :new
  end

  test "should show paper" do
    get :show, id: @paper.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paper.to_param
    assert_response :success
  end

  test "should update paper" do
    put :update, id: @paper.to_param, paper: @paper.attributes
    assert_redirected_to paper_path(assigns(:paper))
  end

  test 'should not update a paper given invalid attributes' do
    put :update, id: @paper.to_param, paper: { title: nil }
    assert_template :edit
  end

  test "should destroy paper" do
    assert_difference('Paper.count', -1) do
      delete :destroy, id: @paper.to_param
    end

    assert_redirected_to papers_path
  end
end
