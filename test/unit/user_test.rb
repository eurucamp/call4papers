require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "it should have a valid fixture called rockstar" do
    user = users(:rockstar)
    assert user.save
  end

  test "it should store the gender in the database" do
    user = users(:rockstar)
    user.gender = "male"
    user.save
    user.reload
    assert_equal "male", user.gender
  end

  test "it allows empty genders" do
    user = users(:rockstar)
    user.gender = ""
    user.save
    user.reload
    assert_equal nil, user.gender
  end
end
