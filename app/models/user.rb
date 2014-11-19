class User < ActiveRecord::Base
  has_secure_password

  has_many :event_attendances
  has_many :attended_events, through: :event_attendances, source: :event
  has_many :created_events, class_name: "Event" 



  validates :email, uniqueness: true
  validates :email, format: {with: /\w+\@\w+\.\w*/}


end
