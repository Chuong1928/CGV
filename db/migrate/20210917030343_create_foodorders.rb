class CreateFoodorders < ActiveRecord::Migration[6.0]
  def change
    create_table :foodorders do |t|
      t.integer :food_id
      t.integer :user_id
      t.integer :quantity
      t.timestamps
    end
  end
end
