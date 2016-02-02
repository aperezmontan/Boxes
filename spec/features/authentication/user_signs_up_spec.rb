require 'rails_helper'

feature "user signs up" do
  let(:name) { "Cal" }
  let(:email) { "cal@me.com" }
  let(:password) { "1234" }
  let(:established_user) { FactoryGirl.create(:user, :name => "Ari",
                                               :email => "ari@me.com",
                                               :password => "123",
                                               :role => "admin") }

  scenario "with good user data" do
    visit "signin"
    click_button "Sign Up"
    expect(current_path).to eq(new_user_path)
    fill_in 'user_name', :with => name
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    fill_in 'user_password_confirmation', :with => password
    click_button "Create User"
    expect(current_path).to eq(root_path)
    expect(page).to have_content 'Hey'
  end

  scenario "with bad data" do
    visit "signin"
    click_button "Sign Up"
    expect(current_path).to eq(new_user_path)
    fill_in 'user_name', :with => established_user.name
    fill_in 'user_password', :with => password
    fill_in 'user_password_confirmation', :with => password
    click_button "Create User"
    expect(page).to have_content 'Email can\'t be blank'
  end
end
