require "test_helper"

class User::HeaderControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_header_show_url
    assert_response :success
  end
end
