class Box < ActiveRecord::Base
  belongs_to :game, :inverse_of => :boxes
  belongs_to :user

  scope :home_score_num, ->(num) { where("home_team_num = ?", num) }
  scope :away_score_num, ->(num) { where("away_team_num = ?", num) }
  scope :by_user, lambda { |user| where(:user_id => user.id) }
  scope :by_game, lambda { |game| where(:game_id => game.id) }
  scope :by_game_id, lambda { |game_id| where(:game_id => game_id) }

end