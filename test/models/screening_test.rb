require 'test_helper'

class ScreeningTest < ActiveSupport::TestCase
  
  
    def setup
      @film_type = film_types(:one)
      @film = films(:one)
      @room = rooms(:one)
      @screening = Screening.new(film_id: @film.id, room_id: @room.id, day_show_film: Time.now, start_film_at: Time.now)
    end
    test "should be valid" do
       @screening.valid?
       assert_empty @screening.errors[:film_id]
       assert_empty @screening.errors[:room_id]
    end

    test "film_id should be present" do
      @screening.film_id = nil
       @screening.invalid?
       assert_not @screening.errors[:film_id].empty?
    end
    test "room_id should be present" do
      @screening.room_id = nil
       @screening.invalid?
       assert_not @screening.errors[:room_id].empty?
    end
end
