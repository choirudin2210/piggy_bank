class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :team_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
