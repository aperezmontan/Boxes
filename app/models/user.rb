class User < ActiveRecord::Base
  has_many :boxes

  def initialize(attributes = {})
    @user_name = attributes[:user_name]
  end

end