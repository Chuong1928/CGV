require 'test_helper'

class OrderTest < ActiveSupport::TestCase

    # test "valid if user_id not blank" do 
    #   order = Order.new(user_id: "123")
    #   order.valid?
    #   assert_empty order.errors[:user_id]
    # end

    # test "valid if user_id and total_payment not blank" do 
    #   order = Order.new(user_id: "123",total_payment: 1000)
    #   order.valid?
    #   assert_empty order.errors[:user_id]
    #   assert_empty order.errors[:total_payment]
    # end
    # test "invalid if user_id is blank" do 
    #   order = Order.new(user_id: "")
    #   order.invalid?
    #   assert_not order.errors[:user_id].empty?
    # end

    # test "invalid if user_id or total_payment is blank" do 
    #   order = Order.new(user_id: "",total_payment: "")
    #   order.invalid?
    #   assert_not order.errors[:user_id].empty?
    #   assert_not order.errors[:total_payment].empty?
    # end
    def setup
      @user = users(:one)
      @order = Order.new(user_id: @user.id, total_payment: 1000)
    end
     
    test "should be valid" do
      assert @order.valid?
    end
    #test xem user ton` tai chua
    test "user id should be present" do
      @order.user_id = nil
      assert_not @order.valid?
    end
    test "total_payment should be present" do
      @order.total_payment = nil
       @order.valid?
       assert_not @order.errors[:total_payment].empty?
      end

end
