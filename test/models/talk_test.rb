require 'test_helper'

class TalkTest < ActiveSupport::TestCase
  test "is valid with title, public_desc, time_slot" do
    user = User.new(name: "Franz", email: "franz@example.com", password: '12345678')
    talk = Talk.new(title: "Foo bar baz", public_description: "Foo bar baz explained", time_slot: "15 Minutes")
    talk.user = user
    assert talk.valid?
  end

  test "is not valid without title" do
    talk = Talk.new(public_description: "Foo bar baz explained", time_slot: "15 Minutes")
    assert_not talk.valid?
  end

  test "is not valid without public description" do
    talk = Talk.new(title: "Foo bar baz", time_slot: "15 Minutes")
    assert_not talk.valid?
  end

  test "is not valid without time slot" do
    talk = Talk.new(title: "Foo bar baz", public_description: "Foo bar baz explained")
    assert_not talk.valid?
  end

  test "is not valid without a user" do
    talk = Talk.new(title: "Foo bar baz", public_description: "Foo bar baz explained", time_slot: "15 Minutes")
    assert_not talk.valid?
  end
end
