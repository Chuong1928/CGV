class CreateSeats < ActiveRecord::Migration[6.0]
  def change
    create_table :seats do |t|
      t.integer  :room_id
      t.integer  :seat_type_id
      t.timestamps
    end
  end
end
