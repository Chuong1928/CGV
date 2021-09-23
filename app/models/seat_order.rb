class SeatOrder < ApplicationRecord
    belongs_to  :order
    belongs_to  :seat
    belongs_to  :screening
    validates :screening_id, :seat_id, :order_id, presence: true 
end
