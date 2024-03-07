require "test_helper"

class Admin::PostBoardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_post_boards_index_url
    assert_response :success
  end
end
