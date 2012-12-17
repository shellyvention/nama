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
      gender: 0,
      role: 0,
      password: "ThePassword-1",
      password_confirmation: "ThePassword-1",
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
  it { should respond_to(:gender) }
  it { should respond_to(:role) }

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

  describe "test full_name" do
    it "should return full name" do
      @user.full_name.should eq("Muster Peter")
    end
  end

  describe "when first_name is not set" do
    before { @user.first_name = nil }
    it "should return last_name" do
      @user.full_name.should eq("Muster")
    end
  end

  describe "when role is set to user" do
    it "should return User" do
      @user.role_name.should eq("User")
    end
  end

  describe "when role is set to admin" do
    before { @user.role = 1 }
    it "should return Admin" do
      @user.role_name.should eq("Admin")
    end
  end

  describe "when role is set to organizer" do
    before { @user.role = 2 }
    it "should return Organizer" do
      @user.role_name.should eq("Organizer")
    end
  end

  describe "User.current works" do
    before do
      User.current = @user
    end

    it "should return the current user" do
      User.current.should equal(@user)
    end

    it "should be signed_in" do
      User.signed_in?.should == true
    end

    it "should not be admin" do
      User.current.is_admin?.should_not == true
    end

    describe "admin" do
      before { @user.role = 1 }

      it "should be admin" do
        User.current.is_admin?.should == true
      end

      it "should be organizer" do
        User.current.is_organizer?.should == true
      end
    end

    describe "organizer" do
      before { @user.role = 2 }

      it "should not be admin" do
        User.current.is_admin?.should_not == true
      end

      it "should be organizer" do
        User.current.is_organizer?.should == true
      end
    end
  end

  describe "default password" do
    before do
      @user.default_pw
      @user.save
    end
    its(:password_digest) { should_not be_blank }
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "signup with locked token" do
    before do
      @user.activation_token = "locked"
      @user.save
    end
    it "should not signup user" do
      @user.signup("password", "password").should == false
    end
  end

  describe "signup" do
    it "should signup user" do
      @user.signup("password", "password").should == true
    end
  end

  describe "signup with short password" do
    it "should not signup user" do
      @user.signup("pass", "pass").should == false
    end
  end

  describe "activate user" do
    before do
      @user.activation_token = "token"
      @user.save
    end
    it "should activate user" do
      @user.activate("token").should == true
    end
    it "should not activate user" do
      @user.activate("tok").should == false
    end
  end
end
