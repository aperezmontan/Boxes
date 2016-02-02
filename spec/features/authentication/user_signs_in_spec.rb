require 'rails_helper'

feature "user signs in" do
  let(:regular_user) { FactoryGirl.create(:user, :name => "Ari",
                                                 :email => "ari@me.com",
                                                 :password => "123") }
  let(:admin_user) { FactoryGirl.create(:user, :name => "Ari",
                                               :email => "ari@me.com",
                                               :password => "123",
                                               :role => "admin") }

  scenario "with valid data" do
    visit "signin"
    fill_in 'login', :with => regular_user.name
    fill_in 'password', :with => regular_user.password
    click_button "Sign In"
    expect(current_path).to eq(root_path)
    expect(page).to have_content 'Hey'
  end

  scenario "with invalid data" do
    visit "signin"
    fill_in 'login', :with => 'user'
    click_button "Sign In"
    expect(page).to have_content 'Either username or password are incorrect'
  end
end
