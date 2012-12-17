FactoryGirl.define do
  factory :user do
    last_name		"Muster"
    first_name		"Peter"
    street			"Musterstrasse 1"
    postal_code		"1111"
    city			"Musterstadt"
    date_of_birth	{ 40.years.ago }
    email			"peter@muster.ch"
    gender			0
    role			1
    password		"ThePassword-1"
    password_confirmation	"ThePassword-1"
  end

  factory :admin, class: User do
    last_name		"Admin"
    first_name		"Peter"
    street			"Musterstrasse 1"
    postal_code		"1111"
    city			"Musterstadt"
    date_of_birth	{ 40.years.ago }
    email			"admin@muster.ch"
    gender			0
    role			1
    password		"ThePassword-1"
    password_confirmation	"ThePassword-1"
  end

  factory :group do
    name            "Herren 1"
  end
end
