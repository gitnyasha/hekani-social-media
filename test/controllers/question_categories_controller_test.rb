require "test_helper"

class QuestionCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get question_categories_show_url
    assert_response :success
  end
end
