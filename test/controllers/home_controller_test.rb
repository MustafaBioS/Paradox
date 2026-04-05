require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "redirects guests from home" do
    get "/home"

    assert_response :redirect
    assert_redirected_to "/?error=login_required"
  end
end
