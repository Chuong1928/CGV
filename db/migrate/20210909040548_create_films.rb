class CreateFilms < ActiveRecord::Migration[6.0]
  def change
    create_table :films do |t|
      t.string  :name
      t.integer :time
      t.integer :film_type_id
      t.string  :country
      t.string  :release_date
      t.string  :director
      t.string  :age_limit
      t.string  :actors
      t.string  :trailer_link
      t.string  :image_url
      t.text    :plot
      t.timestamps
    end
  end
end
