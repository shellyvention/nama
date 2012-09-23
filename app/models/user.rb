class User < ActiveRecord::Base
  attr_accessible :date_of_birth, :email, :first_name, :last_name, :phone_landline, :phone_mobile, :postal_code, :street
end
