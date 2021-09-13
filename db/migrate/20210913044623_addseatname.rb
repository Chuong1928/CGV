class Addseatname < ActiveRecord::Migration[6.0]
  def change
    add_column :seats, :name, :string
  end
end
