# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  last_name      :string(255)
#  first_name     :string(255)
#  street         :string(255)
#  postal_code    :integer
#  phone_landline :string(255)
#  phone_mobile   :string(255)
#  date_of_birth  :date
#  email          :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :date_of_birth, :email, :first_name, :last_name, :phone_landline, :phone_mobile, :postal_code, :street
end
