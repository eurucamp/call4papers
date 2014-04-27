require 'test_helper'

class CommunicationTest < ActiveSupport::TestCase
  test "can set recipients to all users" do
    user = users(:rockstar)

    communication = Communication.new
    communication.recipients = :all_users

    assert communication.recipients.include?(user)
  end
end
