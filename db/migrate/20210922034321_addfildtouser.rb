class Addfildtouser < ActiveRecord::Migration[6.0]
  def change

    add_column :users, :address, :string
    add_column :users, :identificate, :string
  end
end
