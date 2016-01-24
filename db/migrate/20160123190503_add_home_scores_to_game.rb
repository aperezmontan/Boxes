class AddHomeScoresToGame < ActiveRecord::Migration
  def change
    add_column :games, :home_scores, :text
  end
end
