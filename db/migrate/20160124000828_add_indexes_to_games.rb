class AddIndexesToGames < ActiveRecord::Migration
  def change
    add_index :games, :is_active, :name => "index_games_on_is_active"
  end
end
