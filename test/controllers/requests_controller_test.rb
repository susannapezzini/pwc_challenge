require "test_helper"

class RequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get requests_update_url
    assert_response :success
  end
end
