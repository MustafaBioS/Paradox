require "test_helper"

class FaqControllerTest < ActionDispatch::IntegrationTest
  test "renders faq index" do
    get faq_url

    assert_response :success
  end
end
