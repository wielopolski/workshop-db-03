class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.belongs_to :game, null: false, index: false, foreign_key: false
      t.date :played_at, null: false
      t.integer :day, null: false
      t.integer :month, null: false
      t.integer :quarter, null: false
      t.integer :year, null: false
      t.integer :wday, null: false
    end

    add_foreign_key :matches, :games, on_delete: :cascade, on_update: :cascade
    add_index :matches, :game_id
  end
end
