require 'rails_helper'

feature "user views games" do
  let(:regular_user) { FactoryGirl.create(:user, :name => "Cal", :email => "cal@me.com", :password => "123") }

  scenario "that are opened" do
    new_game = FactoryGirl.create(:game, :home_team => "NYG", :away_team => "NYJ")
    login
    visit "games"
    user_should_be_able_to_view_games("NYJ at NYG")
    click_link "NYJ at NYG"
    expect(current_path).to eq(edit_game_path(new_game.id))
  end

  let(:regular_user) { FactoryGirl.create(:user, :name => "Cal", :email => "cal@me.com", :password => "123") }

  scenario "that are locked" do
    locked_game = FactoryGirl.create(:game, :home_team => "DB", :away_team => "CAR", :status => 1)
    login
    visit "games"
    user_should_be_able_to_view_games("CAR at DB")
    click_link "CAR at DB"
    expect(current_path).to eq(game_path(locked_game.id))
  end

  let(:regular_user) { FactoryGirl.create(:user, :name => "Cal", :email => "cal@me.com", :password => "123") }

  scenario "but can't view games that are completed" do
    FactoryGirl.create(:game, :home_team => "CAR", :away_team => "AZ", :status => 2)
    login
    visit "games"
    user_should_not_be_able_to_view_games("AZ at CAR")
    expect(page).to_not have_content 'AZ at CAR'
  end

  private

  def login
    visit "signin"
    fill_in 'login', :with => regular_user.name
    fill_in 'password', :with => regular_user.password
    click_button "SIGN IN"
  end

  def user_should_be_able_to_view_games(title)
    within 'body' do
      expect(page).to have_css 'a', text: title
    end
  end

  def user_should_not_be_able_to_view_games(title)
    within 'body' do
      expect(page).to_not have_css 'a', text: title
    end
  end
end
