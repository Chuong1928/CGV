class Screening < ApplicationRecord
    belongs_to :film
    belongs_to :room
    has_many   :seat_orders,dependent: :destroy
    before_save :set_time_end_film

    def set_time_end_film
      start_film_at = self.start_film_at
      size_of_film = Film.find(self.film_id).time
      self.end_film_at = start_film_at + (size_of_film*60)
    end
end
