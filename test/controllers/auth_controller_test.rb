require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  setup do
    @previous_client_id = ENV["CLIENT_ID"]
    ENV["CLIENT_ID"] = "test-client-id"
  end

  teardown do
    ENV["CLIENT_ID"] = @previous_client_id
  end

  test "hackclub auth entrypoint redirects to oauth authorize" do
    get auth_hackclub_url, params: { email: "test@example.com" }

    assert_response :redirect
    assert_includes response.location, "https://auth.hackclub.com/oauth/authorize"
    assert_includes response.location, "client_id=test-client-id"
    assert_includes response.location, "login_hint=test%40example.com"
  end

  test "hackclub auth entrypoint omits login_hint when email is blank" do
    get auth_hackclub_url, params: { email: "   " }

    assert_response :redirect
    refute_includes response.location, "login_hint="
  end

  test "signout clears session and redirects home" do
    get auth_signout_url

    assert_response :redirect
    assert_redirected_to root_url
  end
end
