class Game < ActiveRecord::Base
  has_many :boxes, :dependent => :destroy

  accepts_nested_attributes_for :boxes

  validate :away_team_present
  validate :home_team_present

  after_initialize :constructor

  def update_boxes(current_user)
    update_picked_boxes(current_user)
    update_unpicked_boxes

    return
  end

private

  def away_team_present
    errors.add(:away_team, "can't be blank") if away_team.blank?
  end

  def constructor
    return unless self.new_record?
    home_team_coords = ["A","B","C","D","E","F","G","H","I","J"]
    away_team_coords = ["A","B","C","D","E","F","G","H","I","J"]
    game_boxes = home_team_coords.product(away_team_coords)
    game_boxes.map { |box| self.boxes.build(:home_team_coord => box[0], :away_team_coord => box[1]) }
  end

  def home_team_present
    errors.add(:home_team, "can't be blank") if home_team.blank?
  end

  def update_picked_boxes(current_user)
    self.boxes.each do |box|
      if box.is_taken && box.user_id.nil?
        box.user_id = current_user.id
      end
    end
  end

  def update_unpicked_boxes
    self.boxes.each do |box|
      if !box.is_taken && box.user_id
        box.user_id = nil
      end
    end
  end
end
