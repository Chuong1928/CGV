class Addcolumntofood < ActiveRecord::Migration[6.0]
  def change
    add_column :foods, :url_img, :string
  end
end
