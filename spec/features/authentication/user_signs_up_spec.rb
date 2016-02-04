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
    visit "users/new"
    expect(current_path).to eq(new_user_path)
    fill_in 'name', :with => name
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    fill_in 'password_confirmation', :with => password
    click_button "CREATE USER"
    expect(current_path).to eq(root_path)
    expect(page).to have_content 'BOXED IN'
  end

  scenario "with bad data" do
    visit "users/new"
    expect(current_path).to eq(new_user_path)
    fill_in 'name', :with => established_user.name
    fill_in 'password', :with => password
    fill_in 'password_confirmation', :with => password
    click_button "CREATE USER"
    expect(page).to have_content 'Email can\'t be blank'
  end
end
