class Box < ActiveRecord::Base
  belongs_to :game, inverse_of: :boxes
  belongs_to :user

  validates_inclusion_of :is_winner, in: [true, false]

  after_initialize :default_values

  scope :losers, -> { where(is_winner: false) }
  scope :winners, -> { where(is_winner: true) }
  scope :by_away_score_num, ->(num) { where(away_team_num: num) }
  scope :by_home_score_num, ->(num) { where(home_team_num: num) }
  scope :by_away_team_coord, ->(letter) { where(away_team_coord: letter) }
  scope :by_home_team_coord, ->(letter) { where(home_team_coord: letter) }
  scope :by_game, ->(game) { where(game_id: game.id) }
  scope :by_game_id, ->(game_id) { where(game_id: game_id) }
  scope :by_winning_scores, lambda { |home_score, away_score|
    by_home_score_num(home_score).by_away_score_num(away_score)
  }
  scope :by_user, ->(user) { where(user_id: user.id) }

  def update_box(current_user)
    return false unless can_be_picked(current_user)
    self.user_id = if user_id == current_user.id
                     nil
                   else
                     current_user.id
    end

    save!
  end

  private

  def can_be_picked(current_user)
    user_id.nil? || user_id == current_user.id
  end

  def default_values
    self.is_winner ||= false
  end
end
