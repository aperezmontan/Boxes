require 'rails_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  it "allows a user to login with the correct credentials" do
    user = Factory(:user)
    visit
  end
end
