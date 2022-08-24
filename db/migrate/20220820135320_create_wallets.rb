class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.references :owner, polymorphic: true, null: false
      t.float :balance, :default => 0

      t.timestamps
    end
  end
end
