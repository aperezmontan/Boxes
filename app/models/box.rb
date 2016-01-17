class Box < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def initialize(attributes = {})
    @home_team_num = attributes[:home_team_num]
    @away_team_num = attributes[:away_team_num]
  end

end