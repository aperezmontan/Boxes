class Game < ActiveRecord::Base
  has_many :boxes, lambda { order "home_team_coord ASC, away_team_coord ASC" }, :dependent => :destroy

  serialize :home_scores
  serialize :away_scores
  serialize :first_quarter
  serialize :second_quarter
  serialize :third_quarter
  serialize :final

  accepts_nested_attributes_for :boxes

  validate :away_team_present
  validate :home_team_present

  after_initialize :constructor
  before_save :populate_numbers

  scope :by_id, lambda { |id| where(:id => id) }
  scope :active, lambda { where(is_active: true) }
  scope :not_active, lambda { where(is_active: false) }

private

  def assign_box_numbers
    return unless self.boxes.first.home_team_num.nil?
    self.boxes.each do |box|
      box.home_team_num = self.home_scores[box.home_team_coord]
      box.away_team_num = self.away_scores[box.away_team_coord]
    end
  end

  def away_team_present
    errors.add(:away_team, "can't be blank") if away_team.blank?
  end

  def constructor
    return unless self.new_record?
    self.is_active = false
    home_team_coords = ["A","B","C","D","E","F","G","H","I","J"]
    away_team_coords = ["A","B","C","D","E","F","G","H","I","J"]
    game_boxes = home_team_coords.product(away_team_coords)
    game_boxes.map { |box| self.boxes.build(:home_team_coord => box[0], :away_team_coord => box[1]) }
  end

  def coords_nums_hash
    Hash[["A","B","C","D","E","F","G","H","I","J"].zip(Array(0..9).shuffle)]
  end

  def create_numbers_for_game
    return unless self.home_scores.nil?
    self.home_scores = coords_nums_hash
    self.away_scores = coords_nums_hash
  end

  def home_team_present
    errors.add(:home_team, "can't be blank") if home_team.blank?
  end

  def populate_numbers
    return unless is_active
    create_numbers_for_game
    assign_box_numbers
  end
end
