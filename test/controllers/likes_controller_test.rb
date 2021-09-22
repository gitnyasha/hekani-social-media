require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "should create like" do
    assert_difference("Like.count") do
      like likes_url, params: { like: { user_id: 1, article_id: 1 } }
    end
    assert true
  end

  # test "should destroy like" do
  #   assert_difference("Like.count", -1) do
  #     delete like_url(@like)
  #   end

  #   assert true
  # end
end
