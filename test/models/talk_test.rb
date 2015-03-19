require 'test_helper'

class TalkTest < ActiveSupport::TestCase
  test "is valid with title, public_desc, time_slot" do
    talk = Talk.new(title: "Foo bar baz", public_description: "Foo bar baz explained", time_slot: "15 Minutes")
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
end
