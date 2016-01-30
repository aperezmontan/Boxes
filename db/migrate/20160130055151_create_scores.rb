class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :home_score
      t.integer :away_score
      t.string  :quarter
      t.boolean :is_final
      t.references :game

      t.timestamps null: false
    end
  end
end
