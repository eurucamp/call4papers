require 'test_helper'

class TalkTest < ActiveSupport::TestCase
  test "is valid with title, public_desc, private_desc, time_slot, at least one call" do
    user = User.new(name: "Franz", email: "franz@example.com", password: '12345678')
    talk = Talk.new(title: "Foo bar baz", public_description: "Foo bar baz explained", time_slot: "15 Minutes", private_description: "secret")
    talk.calls << calls(:one)
    talk.user = user
    assert talk.valid?
  end

  test "is not valid without title" do
    talk = Talk.new(public_description: "Foo bar baz explained", time_slot: "15 Minutes")
    talk.validate
    assert_not_empty talk.errors[:title]
  end

  test "is not valid without public description" do
    talk = Talk.new(title: "Foo bar baz", time_slot: "15 Minutes")
    talk.validate
    assert_not_empty talk.errors[:public_description]
  end

  test "is not valid without private description" do
    talk = Talk.new(title: "Foo bar baz", time_slot: "15 Minutes")
    talk.validate
    assert_not_empty talk.errors[:private_description]
  end

  test "is not valid without time slot" do
    talk = Talk.new(title: "Foo bar baz", public_description: "Foo bar baz explained")
    talk.validate
    assert_not_empty talk.errors[:time_slot]
  end

  test "is not valid without a user" do
    talk = Talk.new(title: "Foo bar baz", public_description: "Foo bar baz explained", time_slot: "15 Minutes")
    talk.validate
    assert_not_empty talk.errors[:user]
  end

  test "is not valid without at least one call" do
    talk = Talk.new(title: "Foo bar baz", public_description: "Foo bar baz explained", time_slot: "15 Minutes")
    talk.validate
    assert_not_empty talk.errors[:calls]
  end
end
