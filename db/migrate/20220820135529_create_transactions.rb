class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :to_wallet_id, null: false, foreign_key: true
      t.integer :from_wallet_id, wallet: true, null: false, foreign_key: true
      t.integer :transaction_type
      t.float :amount, :default => 0
      t.float :last_balance, :default => 0

      t.timestamps
    end
  end
end
