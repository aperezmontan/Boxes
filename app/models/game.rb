class Game < ActiveRecord::Base
  has_many :boxes, :dependent => :destroy

  accepts_nested_attributes_for :boxes

  validate :away_team_present
  validate :home_team_present

  after_initialize :constructor

private

  def away_team_present
    errors.add(:away_team, "can't be blank") if away_team.blank?
  end

  def constructor
    home_team_coords = ["A","B","C","D","E","F","G","H","I","J"]
    away_team_coords = ["A","B","C","D","E","F","G","H","I","J"]
    game_boxes = home_team_coords.product(away_team_coords)
    game_boxes.map { |box| self.boxes.build(:home_team_coord => box[0], :away_team_coord => box[1]) }
  end

  def home_team_present
    errors.add(:home_team, "can't be blank") if home_team.blank?
  end
end
