class Food < ApplicationRecord
    validates :name, presence: true 
    validates :price, numericality: { greater_than: 0 }  
    has_many :foodorders,dependent: :destroy
end
