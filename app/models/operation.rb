class Operation < ApplicationRecord
    validates :seat, presence: true
    validates :seat, :numericality => {
              :greater_than_or_equal_to => 0,
              :less_than_or_equal_to => 30
           }
           
    validates :all_seat, presence: true
    validates :all_seat, :numericality => {
              :greater_than_or_equal_to => 0
           }
end
