class Score < ActiveRecord::Base

  enum :quarter => { :first_quarter => 1, :second_quarter => 2, :third_quarter => 3, :fourth_quarter => 4 }

  #change quarter to be an enum and reference box in next migration

  validates_presence_of :home_score
  validates_presence_of :away_score
  validates_presence_of :quarter

  #should not let a new score be less than an old score.  Raise an issue if this happens

  after_initialize :default_values

  scope :finals, lambda { where(:is_final => true) }

  private

  def default_values
    self.is_final ||= false
  end
end