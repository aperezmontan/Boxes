class Score < ActiveRecord::Base

  enum :quarter => { :first_quarter => 1, :second_quarter => 2, :third_quarter => 3, :fourth_quarter => 4 }

  #change quarter to be an enum and reference box in next migration

  validates_presence_of :home_score
  validates_presence_of :away_score
  validates_presence_of :quarter
  validates_presence_of :game_info

  #should not let a new score be less than an old score.  Raise an issue if this happens

  after_initialize :default_values
  after_save :game_updater #TODO should actually call score updator which calls game updator... but I want the tests to pass for now

  scope :finals, lambda { where(:is_final => true) }

  private

  def default_values
    self.is_final ||= false
  end

  def game_updater
    GameUpdater.update!(self)
  end
end