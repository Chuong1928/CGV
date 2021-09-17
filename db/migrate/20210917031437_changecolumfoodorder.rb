class Changecolumfoodorder < ActiveRecord::Migration[6.0]
  def change
    rename_column :foodorders, :user_id, :order_id
  end
end
