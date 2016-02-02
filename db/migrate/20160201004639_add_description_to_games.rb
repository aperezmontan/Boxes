class AddDescriptionToGames < ActiveRecord::Migration
  def change
    add_column :games, :description, :string
    add_column :games, :first_quarter_home_score, :integer
    add_column :games, :second_quarter_home_score, :integer
    add_column :games, :third_quarter_home_score, :integer
    add_column :games, :fourth_quarter_home_score, :integer
    add_column :games, :first_quarter_away_score, :integer
    add_column :games, :second_quarter_away_score, :integer
    add_column :games, :third_quarter_away_score, :integer
    add_column :games, :fourth_quarter_away_score, :integer
    add_column :games, :first_quarter_winner, :string
    add_column :games, :second_quarter_winner, :string
    add_column :games, :third_quarter_winner, :string
    add_column :games, :fourth_quarter_winner, :string
    remove_column :games, :date, :date_time
  end
end
