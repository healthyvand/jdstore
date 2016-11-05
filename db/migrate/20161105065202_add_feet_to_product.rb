class AddFeetToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :feet, :string
    add_index :products, :feet
  end
end
