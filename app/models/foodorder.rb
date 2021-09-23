class Foodorder < ApplicationRecord
    validates :food_id, presence: true 
    validates :order_id, presence: true
    validates :quantity, numericality: { only_integer: true, greater_than: 0 }
    belongs_to :order
    belongs_to :food
end
