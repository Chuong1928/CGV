class Screening < ApplicationRecord
    belongs_to :film
    belongs_to :room
    has_many   :seat_orders,dependent: :destroy
    before_save :set_time_end_film
    validates :film_id, :room_id, presence: true 
    def set_time_end_film
      start_film_at = self.start_film_at
      size_of_film = Film.friendly.find(self.film_id).time
      self.end_film_at = start_film_at + (size_of_film*60)
    end

    def check_status_of_screen_order(seat_id)
      self.seat_orders.find_by(seat_id: seat_id).order.status if self.seat_orders.find_by(seat_id: seat_id).present?
    end

    def check_seat_id_in_seat_order(seat_id)
      self.seat_orders.pluck(:seat_id).include?(seat_id)
    end
    def film_name
      self.film.name
    end
    def room_name
      self.room.name
    end

    def seat_slot
      room_size = room.size
      room_size - self.seat_orders.count
    end
    def format_start_film_at
      self.start_film_at.strftime("%H:%M - %d/%m/%Y")
    end
end
