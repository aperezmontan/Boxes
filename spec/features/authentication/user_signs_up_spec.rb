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

  scenario "with established name" do
    visit "signin"
    click_button "Sign Up"
    expect(current_path).to eq(new_user_path)
    fill_in 'user_name', :with => established_user.name
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    fill_in 'user_password_confirmation', :with => password
    click_button "Create User"
    expect(page).to have_content 'Name has already been taken'
  end

  scenario "with established email" do
    visit "signin"
    click_button "Sign Up"
    expect(current_path).to eq(new_user_path)
    fill_in 'user_name', :with => name
    fill_in 'user_email', :with => established_user.email
    fill_in 'user_password', :with => password
    fill_in 'user_password_confirmation', :with => password
    click_button "Create User"
    expect(page).to have_content 'Email has already been taken'
  end

  scenario "with password not copied correctly" do
    visit "signin"
    click_button "Sign Up"
    expect(current_path).to eq(new_user_path)
    fill_in 'user_name', :with => name
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    fill_in 'user_password_confirmation', :with => "1098"
    click_button "Create User"
    expect(page).to have_content 'Password confirmation doesn\'t match Password'
  end
end
