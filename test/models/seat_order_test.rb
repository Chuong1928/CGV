require 'test_helper'

class SeatOrderTest < ActiveSupport::TestCase
  def setup
    @film_type = film_types(:one)
    @film = films(:one)
    @room = rooms(:one)
    @screening = screenings(:one)
    @seat = seats(:one)
    @user = users(:one)
    @order = orders(:one)
    @seat_order = SeatOrder.new(screening_id: @screening.id, seat_id: @seat.id,order_id: @order.id)

  end

   test "should be valid" do
    @seat_order.valid?
    assert_empty @seat_order.errors[:screening_id]
    assert_empty @seat_order.errors[:seat_id]
    assert_empty @seat_order.errors[:order_id]
    end
    
    test "screening_id should be present" do
      @seat_order.screening_id = nil
      @seat_order.invalid?
      assert_not @seat_order.errors[:screening_id].empty?
    end

    test "seat_id should be present" do
      @seat_order.seat_id = nil
      @seat_order.invalid?
      assert_not @seat_order.errors[:seat_id].empty?
    end

    test "order_id should be present" do
      @seat_order.order_id = nil
      @seat_order.invalid?
      assert_not @seat_order.errors[:order_id].empty?
    end

end
