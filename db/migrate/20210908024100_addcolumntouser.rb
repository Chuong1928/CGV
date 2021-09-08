class Addcolumntouser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :integer
    add_column :users, :birthday, :date
    add_column :users, :gender, :string
    add_column :users, :city, :string
  end
end
