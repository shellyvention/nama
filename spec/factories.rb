FactoryGirl.define do

  factory :user do
    last_name		        "Muster"
    first_name		        "Peter"
    street			        "Musterstrasse 1"
    postal_code		        "1111"
    city			        "Musterstadt"
    date_of_birth	        { 40.years.ago }
    gender			        0
    email			        "peter.user@muster.ch"
    password		        "ThePassword-1"
    password_confirmation	"ThePassword-1"
    role			        0
    active			        1
  end

  factory :admin, class: User do
    last_name		        "Muster"
    first_name		        "Peter"
    street			        "Musterstrasse 1"
    postal_code		        "1111"
    city			        "Musterstadt"
    date_of_birth	        { 40.years.ago }
    gender			        0
    email			        "peter.admin@muster.ch"
    password		        "ThePassword-1"
    password_confirmation	"ThePassword-1"
    role			        1
    active			        1
  end

  factory :organizer, class: User do
    last_name		        "Muster"
    first_name		        "Peter"
    street			        "Musterstrasse 1"
    postal_code		        "1111"
    city			        "Musterstadt"
    date_of_birth	        { 40.years.ago }
    gender			        0
    email			        "peter.organizer@muster.ch"
    password		        "ThePassword-1"
    password_confirmation	"ThePassword-1"
    role			        2
    active			        1
  end

  factory :inactive, class: User do
    last_name		        "Muster"
    first_name		        "Peter"
    street			        "Musterstrasse 1"
    postal_code		        "1111"
    city			        "Musterstadt"
    date_of_birth	        { 40.years.ago }
    gender			        0
    email			        "peter.locked@muster.ch"
    password		        "ThePassword-1"
    password_confirmation	"ThePassword-1"
    role			        2
    active			        0
  end


  factory :event do
    name        "MyEvent"
    description "MyDescr"
    date        "2012-12-18"
  end

  factory :timeslot do
    start   "2000-01-01 08:00:00"
    finish  "2000-01-01 10:00:00"
  end

  factory :group do
    name "Group 1"
  end
end
