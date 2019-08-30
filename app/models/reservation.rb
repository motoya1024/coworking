class Reservation < ApplicationRecord
  belongs_to :user
  
  validates :meeting_on, presence: true
  validates :telmail_name, length: { maximum: 50 }
end
