class Order < ApplicationRecord
    belongs_to :user
    has_many   :seat_orders
    has_many   :foodorders
end
