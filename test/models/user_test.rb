require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should follow and unfollow a user" do
    marshall = users(:one)
    nyasha = users(:two)
    assert_not marshall.following?(nyasha)
    marshall.follow(nyasha)
    assert marshall.following?(nyasha)
    marshall.unfollow(nyasha)
    assert_not marshall.following?(nyasha)
    assert nyasha.followers.include?(marshall)
    marshall.follow(marshall)
    assert_not marshall.following?(marshall)
  end
end
