class Box < ActiveRecord::Base
  belongs_to :game, :inverse_of => :boxes
  belongs_to :user

  validate :can_be_picked?

  scope :home_score_num, ->(num) { where("home_team_num = ?", num) }
  scope :away_score_num, ->(num) { where("away_team_num = ?", num) }
  scope :by_user, lambda { |user| where(:user_id => user.id) }
  scope :by_game, lambda { |game| where(:game_id => game.id) }
  scope :by_game_id, lambda { |game_id| where(:game_id => game_id) }

private

  def can_be_picked?
    errors.add(:id, "Box already picked") unless self.id.nil? || self.id == @current_user.id
  end

end