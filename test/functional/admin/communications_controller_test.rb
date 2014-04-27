require 'test_helper'

class Admin::CommunicationsControllerTest < ActionController::TestCase
  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  test 'valid communication mails are delivered' do
    user = users(:admin_user)
    sign_in user

    recipients = [users(:rockstar)]
    communication = Communication.create!(sender: user,
                                          body: 'Hello!',
                                          subject: 'test mail',
                                          recipients: recipients)

    ActionMailer::Base.deliveries.clear
    post :deliver, id: communication.id
    assert_not ActionMailer::Base.deliveries.empty?

    mail = ActionMailer::Base.deliveries.last
    assert mail.text_part.body.include?(communication.body)
    assert_equal communication.subject, mail.subject
  end
end
