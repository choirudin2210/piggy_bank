class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.text :name
      t.integer :creator_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
