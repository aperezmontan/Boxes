class AddDateToGames < ActiveRecord::Migration
  def change
    add_column :games, :date, :datetime
    add_column :scores, :game_info, :string
  end
end
