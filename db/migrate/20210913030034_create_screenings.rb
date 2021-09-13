class CreateScreenings < ActiveRecord::Migration[6.0]
  def change
    create_table :screenings do |t|
      t.integer  :film_id
      t.integer  :room_id
      t.datetime :day_show_film
      t.datetime :start_film_at
      t.datetime :end_film_at

      t.timestamps
    end
  end
end
