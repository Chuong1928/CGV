class Order < ApplicationRecord
    validates :user_id, :total_payment, presence: true 
    belongs_to :user
    has_many   :seat_orders,dependent: :destroy
    has_many   :foodorders,dependent: :destroy
end
