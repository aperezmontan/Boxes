class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string  :home_team
      t.string  :away_team
      t.integer :current_home_result
      t.integer :current_away_result
      t.integer :first_quarter_home_result
      t.integer :second_quarter_home_result
      t.integer :third_quarter_home_result
      t.integer :final_home_result
      t.integer :first_quarter_away_result
      t.integer :second_quarter_away_result
      t.integer :third_quarter_away_result
      t.integer :final_away_result

      t.timestamps null: false
    end
  end
end
