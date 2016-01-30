class Score < ActiveRecord::Base
  belongs_to :game

  scope :finals, lambda { where(:is_final => true) }
end