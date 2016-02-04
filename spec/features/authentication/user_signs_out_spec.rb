require 'rails_helper'

feature "user signs out" do
  let(:regular_user) { FactoryGirl.create(:user, :name => "Ari",
                                                 :email => "ari@me.com",
                                                 :password => "123") }

  scenario "with valid data" do #only scenario
    visit "signin"
    fill_in 'login', :with => regular_user.name
    fill_in 'password', :with => regular_user.password
    click_button "SIGN IN"
    expect(current_path).to eq(root_path)
    expect(page).to have_content 'Sign Out'
    click_link "Sign Out"
    expect(current_path).to eq(signin_path)
  end
end