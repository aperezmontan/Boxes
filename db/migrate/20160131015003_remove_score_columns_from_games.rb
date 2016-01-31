class RemoveScoreColumnsFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :first_quarter_home_score, :integer
    remove_column :games, :second_quarter_home_score, :integer
    remove_column :games, :third_quarter_home_score, :integer
    remove_column :games, :final_home_score, :integer
    remove_column :games, :first_quarter_away_score, :integer
    remove_column :games, :second_quarter_away_score, :integer
    remove_column :games, :third_quarter_away_score, :integer
    remove_column :games, :final_away_score, :integer
  end
end
