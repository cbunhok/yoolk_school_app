FactoryGirl.define do
	factory :course do
		title "Variable"
		short_title "V"
		duration 7
		cost_per_day 8
		summary "Declare Variable"
		is_published true
	end
end