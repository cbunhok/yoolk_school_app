require 'spec_helper'

describe "route to Category" do
	it "routes /categories/1 to categories#destroy" do
		expect(delete: "/categories/1").to route_to(
		  controller: "categories",
		  action: "destroy",
		  id: "1"
		)
	end
end