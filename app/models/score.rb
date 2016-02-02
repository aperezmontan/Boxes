class Score < ActiveRecord::Base
#TODO add tests for status presence
  enum :quarter => { :first_quarter => 1, :second_quarter => 2, :third_quarter => 3, :fourth_quarter => 4 }
  enum :status => { :CURRENT => 0, :AGED => 1 }

  #change quarter to be an enum and reference box in next migration

  validates_presence_of :home_score
  validates_presence_of :away_score
  validates_presence_of :quarter
  validates_presence_of :game_info
  validates_presence_of :status

  #should not let a new score be less than an old score.  Raise an issue if this happens

  after_initialize :default_values
  after_save :game_updater #TODO should actually call score updator which calls game updator... but I want the tests to pass for now

  scope :finals, lambda { where(:is_final => true) }
  scope :current, lambda { where(:status => 0) }
  scope :aged, lambda { where(:status => 1) }

  private

  def default_values
    self.is_final ||= false
  end

  def game_updater
    ScoreUpdater.update!(self)
  end
end