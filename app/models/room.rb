class Room < ApplicationRecord
    
    has_many   :screenings,dependent: :destroy
    has_many   :seats,dependent: :destroy

    after_save :create_vip_seat, :create_normal_seat

    private
    def create_vip_seat
      vip_seat = self.vip_seat
        vip_seat.times do |index|
            Seat.create(room_id: self.id, seat_type_id: 1, name: "")
        end
    end

    def create_normal_seat
        normal_seat = self.normal_seat
        normal_seat.times do |index|
              Seat.create(room_id: self.id, seat_type_id: 2,name: "",)
          end
    end
end
