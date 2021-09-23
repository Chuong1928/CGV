require 'test_helper'

class FilmTypeTest < ActiveSupport::TestCase
  test "valid if name is not bank" do
    type_film = FilmType.new(name: "123")
    assert type_film.valid?
  end
  test "invalid if name is  bank" do
    type_film = FilmType.new(name: "")
    type_film.valid?
    assert_not type_film.errors[:name].empty?
  end
  
end
