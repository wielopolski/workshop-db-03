class CreateScores < ActiveRecord::Migration[5.1]
  def up
    create_table :scores do |t|
      t.belongs_to :match, null: false, index: false, foreign_key: false
      t.belongs_to :player, null: false, index: false, foreign_key: false
      t.integer :points, null: false, default: 0
    end

    add_foreign_key :scores, :matches, on_delete: :cascade, on_update: :cascade
    add_foreign_key :scores, :players, on_delete: :cascade, on_update: :cascade
    add_index :scores, :match_id
    add_index :scores, :player_id
    add_index :scores, [:match_id, :player_id], unique: true

    execute <<~SQL
      ALTER TABLE scores ADD CONSTRAINT non_negative_value CHECK (points >= 0)
    SQL
  end

  def down
    drop_table :scores
  end
end
