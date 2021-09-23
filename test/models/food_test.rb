require 'test_helper'

class FoodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "valid if name not blank" do 
      food = Food.new(name: "123")
      food.valid?
      assert_empty food.errors[:name]  
  end

  test "invalid if name is blank" do 
    food = Food.new(name: "")
    food.invalid?
    assert_not food.errors[:name].empty?    
  end

  test "valid if price greater_than 0" do 
    food = Food.new(price: 10)
    food.valid?
    assert_empty food.errors[:price]     
  end

  test "invalid if price less than 0" do 
    food = Food.new(price: -10)
    food.invalid?
    assert_not food.errors[:price].empty?    
  end

end
