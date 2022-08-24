class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.text :name
      t.float :price, :default => 0
      t.integer :numbers, :default => 0
      t.integer :available, :default => 0

      t.timestamps
    end
  end
end
