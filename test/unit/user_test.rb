# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  last_name        :string(255)
#  first_name       :string(255)
#  street           :string(255)
#  postal_code      :integer
#  city             :string(255)
#  phone_landline   :string(255)
#  phone_mobile     :string(255)
#  date_of_birth    :date
#  email            :string(255)
#  password_digest  :string(255)
#  activation_token :string(255)
#  active           :boolean          default(FALSE), not null
#  remember_token   :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
