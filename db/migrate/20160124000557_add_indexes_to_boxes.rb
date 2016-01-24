class AddIndexesToBoxes < ActiveRecord::Migration
  def change
    add_index :boxes, :home_team_num, :name => "index_boxes_on_home_score_num"
    add_index :boxes, :away_team_num, :name => "index_boxes_on_away_score_num"
    add_index :boxes, :user_id, :name => "index_boxes_on_user_id"
    add_index :boxes, :game_id, :name => "index_boxes_on_game_id"
  end
end
