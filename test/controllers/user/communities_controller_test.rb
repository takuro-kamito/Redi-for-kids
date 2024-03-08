require "test_helper"

class User::CommunitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_communities_index_url
    assert_response :success
  end
end
