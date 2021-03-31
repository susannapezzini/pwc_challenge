require "test_helper"

class BanksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get banks_new_url
    assert_response :success
  end

  test "should get create" do
    get banks_create_url
    assert_response :success
  end
end
