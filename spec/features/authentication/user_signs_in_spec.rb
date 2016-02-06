require 'rails_helper'

feature 'user signs in' do
  let(:regular_user) do
    FactoryGirl.create(:user, name: 'Ari',
                              email: 'ari@me.com',
                              password: '123')
  end
  let(:admin_user) do
    FactoryGirl.create(:user, name: 'Ari',
                              email: 'ari@me.com',
                              password: '123',
                              role: 'admin')
  end

  scenario 'with valid data' do
    visit 'signin'
    fill_in 'login', with: regular_user.name
    fill_in 'password', with: regular_user.password
    click_button 'SIGN IN'
    expect(current_path).to eq(root_path)
    expect(page).to have_content 'BOXED'
  end

  scenario 'with invalid data' do
    visit 'signin'
    fill_in 'login', with: 'user'
    click_button 'SIGN IN'
    expect(page).to have_content 'Either username or password are incorrect'
  end
end
