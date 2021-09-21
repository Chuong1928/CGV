class Order < ApplicationRecord
    belongs_to :user
    has_many   :seat_orders,dependent: :destroy
    has_many   :foodorders,dependent: :destroy
end
