# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  first_name     :string(255)
#  last_name      :string(255)
#  email          :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  identifier_url :string(255)
#  admin          :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :identifier_url

  before_save { self.email.downcase! }

  validates :first_name, length: { maximum: 100 }
  validates :last_name, length: { maximum: 100 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
