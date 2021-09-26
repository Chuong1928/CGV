class Film < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged
    
    belongs_to :film_type
    has_many   :screenings,dependent: :destroy
    validates :name, :time, presence: true 
    validates :time, numericality: { greater_than: 0 } 

    ransack_alias :key, :name_or_actors_or_director_or_plot_or_country_or_age_limit_or_film_type_name
end
