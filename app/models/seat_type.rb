class SeatType < ApplicationRecord
    has_many :seats,dependent: :destroy
end
