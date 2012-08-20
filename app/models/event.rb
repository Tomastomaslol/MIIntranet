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
#

class Event < ActiveRecord::Base
  has_event_calendar
  attr_accessible :name, :start_at, :end_at, :user_id
  belongs_to :user
  
  validates :name, presence: true
  validates :user_id, presence: true
  
  default_scope order: 'events.created_at DESC'
end
