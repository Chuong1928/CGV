class Addcolumntoroom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :size, :integer
    add_column :rooms, :vip_seat, :integer
    add_column :rooms, :normal_seat, :integer
  end
end
