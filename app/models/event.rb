# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_at   :datetime
#  end_at     :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  userid     :integer
#  user_id    :integer
#

class Event < ActiveRecord::Base
  has_event_calendar
  attr_accessible :name, :start_at, :end_at, :user_id
  belongs_to :user
  has_many :ownerships
  has_many :users, through: :Ownerships
  
  validates :name, presence: true
  validates :user_id, presence: true
  validates :start_at, :presence => { :message => "must have a start date/time"}
  validates :end_at, :presence => { :message => "must have an end date/time"}
  validate :start_at_must_be_before_end_at
  
  default_scope order: 'events.created_at DESC'
  
  after_create :create_ownership
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
  
  def create_ownership
    Ownership.create event_id: self.id, user_id: user.id
  end
  
  def start_at_must_be_before_end_at
    errors.add(:end_at, "must be after end date/time") unless
    self.start_at < self.end_at    
  end
  
end
