require 'test_helper'

class FoodorderTest < ActiveSupport::TestCase
 
  test "valid if food_id and order_id is not bank" do
    food_order = Foodorder.new(food_id: 1, order_id: 1)
    food_order.valid?
    assert_empty food_order.errors[:food_id]
    assert_empty food_order.errors[:order_id] 
  end

  test "invalid if food_id and order_id is  bank" do
    food_order = Foodorder.new(food_id: "", order_id: "")
    food_order.invalid?
    assert_not food_order.errors[:food_id].empty? || food_order.errors[:order_id].empty?
  end
  test "invalid if food_id  is  bank" do
    food_order = Foodorder.new(food_id: "", order_id: 1)
    food_order.invalid?
    assert_not food_order.errors[:food_id].empty? 
  end
  test "invalid if order_id is  bank" do
    food_order = Foodorder.new(food_id: 1, order_id: "")
    food_order.invalid?
    assert_not food_order.errors[:order_id].empty?
  end
  test "valid if quantity greater_than 0" do 
    food = Foodorder.new(quantity: 10)
    food.valid?
    assert_empty food.errors[:quantity]     
  end

  test "invalid if quantity less than 0" do 
    food = Foodorder.new(quantity: -10)
    food.invalid?
    assert_not food.errors[:quantity].empty?    
  end

end
