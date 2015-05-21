require 'test_helper'

class Admin::NotesControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  test 'should create notes' do
    sign_in users(:admin_user)

    proposal = proposals(:one)
    post :create, id: proposal.id, note: { content: 'some text' }
    assert_response :redirect
    assert_equal proposal.notes.size, 1
    assert_equal proposal.notes.first.content, 'some text'
  end

  test 'should update notes' do
    sign_in users(:admin_user)

    proposal = proposals(:one)
    proposal.notes.create! user_id: users(:admin_user).id, content: 'text'
    put :update, id: proposal.id, note: { content: 'some text' }
    assert_response :redirect
    assert_equal proposal.notes.size, 1
    assert_equal proposal.notes.first.content, 'some text'
  end
end
