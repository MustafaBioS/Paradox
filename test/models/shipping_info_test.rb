require "test_helper"

class ShippingInfoTest < ActiveSupport::TestCase
  test "birth_date is persisted directly" do
	shipping_info = ShippingInfo.new(
	  user: users(:one),
	  first_name: "Mustafa",
	  last_name: "Hany",
	  email: "mustafa@example.com",
	  birth_date: Date.new(2010, 4, 21),
	  address_line_1: "TEST ADDRESS",
	  country: "Country",
	  city: "City",
	  state: "State",
	  postal_code: "ZIP"
	)

	assert shipping_info.valid?
	assert_equal Date.new(2010, 4, 21), shipping_info.birth_date
	assert shipping_info.save!
  end
end
