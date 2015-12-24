class Box < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

end