class Box < ActiveRecord::Base
  belongs_to :game, :inverse_of => :boxes
  belongs_to :user

  validates_inclusion_of :is_winner, :in => [true, false]

  after_initialize :default_values

  scope :losers, lambda { where(:is_winner => false) }
  scope :winners, lambda { where(:is_winner => true) }
  scope :by_away_score_num, lambda { |num| where(:away_team_num => num) }
  scope :by_home_score_num, lambda { |num| where(:home_team_num => num) }
  scope :by_game, lambda { |game| where(:game_id => game.id) }
  scope :by_game_id, lambda { |game_id| where(:game_id => game_id) }
  scope :by_user, lambda { |user| where(:user_id => user.id) }

  def update_box(current_user_id)
    return false unless can_be_picked(current_user_id)
    if self.user_id == current_user_id
      self.user_id = nil
    else
      self.user_id = current_user_id
    end

    self.save!
  end

  private

  def can_be_picked(current_user_id)
    self.user_id == nil || self.user_id == current_user_id
  end

  def default_values
    self.is_winner ||= false
  end
end