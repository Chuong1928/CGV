class Food < ApplicationRecord
    has_many :foodorders,dependent: :destroy
end
