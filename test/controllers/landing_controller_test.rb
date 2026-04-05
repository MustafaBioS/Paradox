require "test_helper"

class LandingControllerTest < ActionDispatch::IntegrationTest
  test "guests can access landing page" do
    get root_url
    assert_response :success
  end

  test "logged-in users are redirected from landing to home" do
    get root_url, env: { "rack.session" => { user_id: users(:one).id } }

    assert_response :redirect
    assert_redirected_to home_url
  end
end
