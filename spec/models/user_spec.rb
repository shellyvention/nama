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
#  gender           :integer
#  email            :string(255)
#  password_digest  :string(255)
#  activation_token :string(255)
#  active           :boolean          default(FALSE), not null
#  remember_token   :string(255)
#  role             :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe User do

	before do
		@user = User.new(
			last_name: "Muster",
			first_name: "Peter",
			street: "Musterstrasse 1",
			postal_code: "1000",
			city: "Musterstadt",
			date_of_birth: "1970-01-01",
			email: "peter.muster@muster.ch")
	end

	subject { @user }

	it { should respond_to(:last_name) }
	it { should respond_to(:first_name) }
	it { should respond_to(:street) }
	it { should respond_to(:postal_code) }
	it { should respond_to(:city) }
	it { should respond_to(:date_of_birth) }
	it { should respond_to(:phone_landline) }
	it { should respond_to(:phone_mobile) }

	it { should be_valid }

	describe "when last_name is not present" do
		before { @user.last_name = " " }
		it { should_not be_valid }
	end

	describe "when first_name is not present" do
		before { @user.first_name = " " }
		it { should_not be_valid }
	end

	describe "when street is not present" do
		before { @user.street = " " }
		it { should_not be_valid }
	end

	describe "when postal_code is not present" do
		before { @user.postal_code = " " }
		it { should_not be_valid }
	end

	describe "when city is not present" do
		before { @user.city = " " }
		it { should_not be_valid }
	end

	describe "when date_of_birth is not present" do
		before { @user.date_of_birth = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when last_name is too long" do
		before { @user.last_name = "a" * 41 }
		it { should_not be_valid }
	end

	describe "when first_name is too long" do
		before { @user.first_name = "a" * 41 }
		it { should_not be_valid }
	end

	describe "when street is too long" do
		before { @user.street = "a" * 41 }
		it { should_not be_valid }
	end

	describe "when city is too long" do
		before { @user.city = "a" * 41 }
		it { should_not be_valid }
	end

	describe "when postal_code is too short" do
		before { @user.postal_code = 111 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.
				foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org first.last@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end
		end
	end

	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end
end
