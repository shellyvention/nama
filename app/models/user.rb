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
#  role             :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ActiveRecord::Base
    attr_accessible :date_of_birth, :email, :first_name, :last_name,
        :phone_landline, :phone_mobile, :postal_code, :street, :city,
        :password, :password_confirmation, :activation_token, :active,
		:role

    has_secure_password

    has_many :group_members
    has_many :groups, through: :group_members
    has_many :events, dependent: :restrict
    has_many :timeslots
	  has_many :ratings

    before_save { |user| user.email = email.downcase }
    before_save :create_remember_token

    validates :first_name, :last_name, :street, :city,
        presence: true, length: { minimum: 2, maximum: 40 }
    validates :postal_code, presence: true, length: { minimum: 4, maximum: 10 }
    validates :date_of_birth, presence: true

    # Breaking down the email regex:
    #
    #  /                start of regex
    #  \A               match start of a string
    #  [\w+\-.]+        at least one word character, plus, hyphen, or dot
    #  @                literal "at sign"
    #  [a-z\d\-.]+      at least one letter, digit, hyphen, or dot
    #  \.               literal dot
    #  [a-z]+           at least one letter
    #  \z               match end of a string
    #  /                end of regex
    #  i                case insensitive
    #
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }

    validates :password, allow_nil: true, length: { minimum: 6 }

    def self.current=(user)
      @current_user = user
    end

    def self.current
      @current_user
    end

    def self.signed_in?
      !@current_user.nil?
    end

    def is_admin?
      self.role == 1
    end

    def is_organizer?
      is_admin? || self.role == 2
    end

    def full_name
      if !first_name.nil?
        last_name + " " + first_name
      else
        last_name
      end
    end

    def role_name
      case role
        when 0
          "User"
        when 1
          "Admin"
        when 2
          "Organizer"
      end
    end

	def default_pw
	  self.password = self.password_confirmation = SecureRandom.urlsafe_base64
	end

    def signup(pw, pw_confirmation)
	  if self.activation_token == "locked"
	    return false
      end

      self.password = pw
      self.password_confirmation = pw_confirmation
      self.activation_token = SecureRandom.urlsafe_base64

      if self.save
        UserMailer.activation_email(self).deliver
      else
        return false
      end
    end

    def activate(token)
      if self.activation_token == token
        self.active = true
        self.activation_token = nil
        self.save
      else
        return false
      end
    end

    default_scope order(:last_name, :first_name)
    scope :event_participants, lambda { |event|
	  where(
        "id IN (SELECT user_id FROM timeslots " +
        "WHERE event_id = :event_id)", event_id: event.id)
    }

    private
      def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
      end
end
