class Game < ActiveRecord::Base
  has_many :boxes, lambda { order "home_team_coord ASC, away_team_coord ASC" }, :dependent => :destroy
  has_many :scores, lambda { order "updated_at DESC" }

  accepts_nested_attributes_for :boxes

  validate :away_team_present
  validate :home_team_present

  after_initialize :constructor
  before_save :populate_numbers
  before_save :update_previous_winners(self.scores.finals)

  scope :active, lambda { where(:is_active => true) }
  scope :not_active, lambda { where(:is_active => false) }
  scope :by_id, lambda { |id| where(:id => id) }
  scope :by_home_team, lambda { |home_team| where(:home_team => home_team) }
  scope :by_away_team, lambda { |away_team| where(:away_team => away_team) }

  COORDINATES = %w{ A B C D E F G H I J }.freeze
  BOX_NUMBERS = Array(0..9).freeze

private

  def away_team_present
    errors.add(:away_team, "can't be blank") if away_team.blank?
  end

  def constructor
    return unless self.new_record?
    self.is_active = false
    game_boxes = COORDINATES.product(COORDINATES)
    game_boxes.map { |box| self.boxes.build(:home_team_coord => box[0], :away_team_coord => box[1]) }
  end

  def clean_up_boxes(true_winning_boxes) #self correction
    return if self.boxes.winners.size == true_winning_boxes.size
    final_scores_array = self.scores.finals.pluck(:home_score % 10, :away_score % 10)
    dirty_boxes = true_winning_boxes.concat(self.boxes.winners.concat)
    dirty_boxes.reject! { |box| true_winning_boxes.include?(box) && self.boxes.winners.include?(box) }
    dirty_boxes.each do |box|
      if final_scores_array.include?(box)
        box.update_box(:is_winner => true)
      else
        box.update_box(:is_winner => false)
      end
    end
  end

  def coords_nums_hash
    Hash[COORDINATES.zip(BOX_NUMBERS.shuffle)]
  end

  def home_team_present
    errors.add(:home_team, "can't be blank") if home_team.blank?
  end

  def populate_numbers
    binding.pry
    return unless is_active && self.boxes.pluck(:home_team_num) == [] && self.boxes.pluck(:away_team_num) == []#Test this return
    random_home_numbers_hash = coords_nums_hash
    random_away_numbers_hash = coords_nums_hash
    self.boxes.each do |box|
      box.home_team_num = random_home_numbers_hash[box.home_team_coord]
      box.away_team_num = random_away_numbers_hash[box.away_team_coord]
    end
  end

  def update_previous_winners(winning_scores_array)
    return unless self.scores == [] #Test this return
    if winning_scores_array.size != self.boxes.winners.size
      true_winning_boxes = winning_scores_array.map do |score| #make sure true wining boxes returns an array of boxes
        box = self.boxes.by_home_score_num(score.home_score % 10).by_away_score_num(score.away_score % 10)
        box.update_box(:is_winner => true)
      end
    end
    clean_up_boxes(true_winning_boxes) unless winning_scores_array.size == self.boxes.winners.size
  end
end
