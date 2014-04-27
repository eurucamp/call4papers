require 'test_helper'

class Mentor::FeedbacksControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  test 'valid feedback mails are delivered' do
    paper = papers(:one)
    feedback = Feedback.new(feedback: 'Nice job')

    sign_in users(:mentor_user)

    ActionMailer::Base.deliveries.clear
    post :contact, id: paper.id, feedback: { feedback: feedback.feedback }
    assert_not ActionMailer::Base.deliveries.empty?, "mail not sent"

    mail = ActionMailer::Base.deliveries.last
    assert mail.body.include?(feedback.feedback)
  end

  test 'empty feedbacks mails are not delivered' do
    paper = papers(:one)
    feedback = Feedback.new(feedback: '')

    sign_in users(:mentor_user)

    ActionMailer::Base.deliveries.clear
    post :contact, id: paper.id, feedback: { feedback: feedback.feedback }
    assert ActionMailer::Base.deliveries.empty?, "mail sent!"
  end
end
