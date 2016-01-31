class AddEnumsToScoresAndGames < ActiveRecord::Migration
  def change
    remove_column :scores, :quarter, :string
    remove_column :scores, :game_id, :integer
    remove_column :games, :is_active, :boolean
    add_column :scores, :quarter, :integer
    add_column :games, :status, :integer, :default => 0
  end
end
