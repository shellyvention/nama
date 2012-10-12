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
#  city           :string(255)
#

class User < ActiveRecord::Base
	attr_accessible :date_of_birth, :email, :first_name, :last_name,
		:phone_landline, :phone_mobile, :postal_code, :street, :city

	has_many :group_members
	has_many :groups, through: :group_members

	before_save { |user| user.email = email.downcase }

	validates :first_name, :last_name, :street, :city,
		presence: true, length: { minimum: 2, maximum: 40 }
	validates :postal_code, presence: true, length: { minimum: 4, maximum: 10 }
	validates :date_of_birth, presence: true

	# Breaking down the email regex:
	#
	#  /				start of regex
	#  \A				match start of a string
	#  [\w+\-.]+		at least one word character, plus, hyphen, or dot
	#  @				literal "at sign"
	#  [a-z\d\-.]+		at least one letter, digit, hyphen, or dot
	#  \.				literal dot
	#  [a-z]+			at least one letter
	#  \z				match end of a string
	#  /				end of regex
	#  i				case insensitive
	#
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }
end
