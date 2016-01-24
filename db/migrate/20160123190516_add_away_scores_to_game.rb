class AddAwayScoresToGame < ActiveRecord::Migration
  def change
    add_column :games, :away_scores, :text
  end
end
