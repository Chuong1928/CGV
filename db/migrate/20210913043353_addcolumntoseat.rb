class Addcolumntoseat < ActiveRecord::Migration[6.0]
  def change
    add_column :seats, :status, :boolean, default: false
  end
end
