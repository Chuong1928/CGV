require 'test_helper'

class FilmTest < ActiveSupport::TestCase
  test "invalid if name is not blank" do
      film = Film.new(name: "hihi")
      film.valid?
      assert_empty film.errors[:name]
    end

  test "invalid if name is blank" do
      film = Film.new(name: "")
      assert film.invalid?
      assert film.errors[:name].any?
    end

  test "valid if time greater than 0" do 
    film = Film.new(name: "123", time: 10)
    film.valid?
    #khang dịnh test nay` la dung
    assert_empty film.errors[:time]
    assert_empty film.errors[:name]
  end

  test "invalid if time greater than 0" do 
      film = Film.new(name: "123", time: -1)
      film.valid?
      assert_empty film.errors[:name]
      assert film.errors[:time].any?
      #assert_not film.errors[:time].empty?
    end

  test "valid if time not blank" do 
      film = Film.new(time: "")
      assert film.invalid?
      assert film.errors[:name].any?
      assert film.errors[:time].any?
      
    end


  
end
