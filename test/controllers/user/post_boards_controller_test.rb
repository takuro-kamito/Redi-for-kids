require "test_helper"

class User::PostBoardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_post_boards_index_url
    assert_response :success
  end
end
