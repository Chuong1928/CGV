class Seat < ApplicationRecord
    belongs_to :seat_type
    has_many   :seat_orders
    belongs_to :room
end
