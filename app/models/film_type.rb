class FilmType < ApplicationRecord
    validates :name, presence: true  
    has_many :films
end
