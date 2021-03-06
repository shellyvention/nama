# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base
  attr_accessible :name

  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members

  validates :name, presence: true, length: { minimum: 2, maximum: 40 }
end
