class SeatOrder < ApplicationRecord
    belongs_to  :order
    belongs_to  :seat
    belongs_to  :screening
    validates :seat_id, presence: true,uniqueness: true
end
