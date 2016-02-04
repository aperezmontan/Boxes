class Game < ActiveRecord::Base
  has_many :boxes, lambda { order "home_team_coord ASC, away_team_coord ASC" }, :dependent => :destroy

  COORDINATES = %w{ A B C D E F G H I J }.freeze
  BOX_NUMBERS = Array(0..9).freeze

  enum :status => { :CREATED => 0, :ACTIVE => 1, :COMPLETED => 2 }

  accepts_nested_attributes_for :boxes


#TODO seems I can't call boxes on games either
#TODO add test for setting box numbers


  validate :away_team_present
  validate :home_team_present

  after_initialize :constructor
  before_save :populate_numbers

  scope :created, lambda { where(:status => 0) }
  scope :active, lambda { where(:status => 1) }
  scope :completed, lambda { where(:status => 2) }
  scope :by_away_team, lambda { |away_team| where(:away_team => away_team) }
  scope :by_description, lambda { |description| where(:description => description) }
  scope :by_home_team, lambda { |home_team| where(:home_team => home_team) }
  scope :by_id, lambda { |id| where(:id => id) }

private

  def away_team_present
    errors.add(:away_team, "can't be blank") if away_team.blank?
  end

  def constructor
    return unless self.new_record?
    self.description = "#{self.away_team} vs #{self.home_team}"
    game_boxes = COORDINATES.product(COORDINATES)
    game_boxes.map { |box| self.boxes.build(:home_team_coord => box[0], :away_team_coord => box[1]) }
  end

  def coords_nums_hash
    Hash[COORDINATES.zip(BOX_NUMBERS.shuffle)]
  end

  def home_team_present
    errors.add(:home_team, "can't be blank") if home_team.blank?
  end

  def populate_numbers
    return if status == "CREATED" || self.boxes.pluck(:home_team_num).uniq != [nil] || self.boxes.pluck(:away_team_num).uniq != [nil]
    random_home_numbers_hash = coords_nums_hash
    random_away_numbers_hash = coords_nums_hash
    self.boxes.each do |box|
      box.home_team_num = random_home_numbers_hash[box.home_team_coord]
      box.away_team_num = random_away_numbers_hash[box.away_team_coord]
    end
  end
end
