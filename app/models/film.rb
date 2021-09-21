class Film < ApplicationRecord
    belongs_to :film_type
    has_many   :screenings,dependent: :destroy
    ransack_alias :key, :name_or_actors_or_director_or_plot_or_country_or_age_limit_or_film_type_name
end
