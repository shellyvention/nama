FactoryGirl.define do
  factory :user do
    last_name		"Muster"
    first_name		"Peter"
    street			"Musterstrasse 1"
    postal_code		"1111"
    city			"Musterstadt"
    date_of_birth	{ 40.years.ago }
    email			"peter@muster.ch"
  end
end
