class AddSpecificQuarterScoresToGames < ActiveRecord::Migration
  def change
    add_column :games, :first_quarter_home_score, :integer
    add_column :games, :second_quarter_home_score, :integer
    add_column :games, :third_quarter_home_score, :integer
    add_column :games, :final_home_score, :integer
    add_column :games, :first_quarter_away_score, :integer
    add_column :games, :second_quarter_away_score, :integer
    add_column :games, :third_quarter_away_score, :integer
    add_column :games, :final_away_score, :integer
    add_column :games, :name, :string
    add_column :games, :price, :integer

    remove_column :games, :first_quarter, :text
    remove_column :games, :second_quarter, :text
    remove_column :games, :third_quarter, :text
    remove_column :games, :final, :text
    remove_column :games, :home_scores, :text
    remove_column :games, :away_scores, :text
  end
end
