class Score < ActiveRecord::Base
  belongs_to :game

  #change quarter to be an enum in next migration

  validates_presence_of :home_score
  validates_presence_of :away_score
  validates_presence_of :quarter

  after_initialize :default_values

  scope :finals, lambda { where(:is_final => true) }

  private

  def default_values
    self.is_final ||= false
  end


end