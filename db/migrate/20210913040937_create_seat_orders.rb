class CreateSeatOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :seat_orders do |t|
      t.integer  :screening_id
      t.integer  :seat_id
      t.integer  :order_id
      t.boolean  :status
      t.timestamps
    end
  end
end
