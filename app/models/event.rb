class Event < ActiveRecord::Base
  belongs_to :organizer, foreign_key: :user_id, class_name: "User"
  has_many :attendances, class_name: "EventAttendance"
  has_many :attendees, through: :attendances, source: :user
end
