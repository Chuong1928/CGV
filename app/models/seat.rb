class Seat < ApplicationRecord
    belongs_to :seat_type
    has_many   :seat_orders,dependent: :destroy
    belongs_to :room
end
