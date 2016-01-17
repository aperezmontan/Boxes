class Game < ActiveRecord::Base
  has_many :boxes

  validate :away_team_present
  validate :home_team_present

private

  def away_team_present
    errors.add(:away_team, "can't be blank") if away_team.blank?
  end

  def home_team_present
    errors.add(:home_team, "can't be blank") if home_team.blank?
  end
end