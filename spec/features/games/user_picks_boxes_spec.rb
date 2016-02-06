require 'rails_helper'

feature 'user picks boxes' do
  let(:regular_user) { FactoryGirl.create(:user, name: 'Cal', email: 'cal@me.com', password: '123') }

  scenario 'that are in an open game' do
    box_picker = FactoryGirl.create(:user, name: 'Cindy', email: 'cym@me.com', password: '123', id: 2)
    new_game = FactoryGirl.create(:game, home_team: 'NYG', away_team: 'NYJ')
    pick_random_boxes(new_game)
    login
    visit 'games'
    click_link 'NYJ at NYG'
    box_count = count_user_boxes
    user_should_be_able_to_view_and_submit_boxes
    user_should_be_able_to_view_box_letters
    user_should_be_able_to_pick(blue_boxes(new_game))
    expect(count_user_boxes).to eq(box_count + 1)
    box_count = count_user_boxes
    user_should_be_able_to_pick(green_boxes)
    expect(count_user_boxes).to eq(box_count - 1)
    user_should_not_be_able_to_pick(red_boxes)
    expect(count_user_boxes).to eq(0) # because user unpicked the only box they picked above
  end

  let(:regular_user) { FactoryGirl.create(:user, name: 'Cal', email: 'cal@me.com', password: '123') }

  scenario "but can't pick boxes from games that are locked" do
    locked_game = FactoryGirl.create(:game, home_team: 'DB', away_team: 'CAR', description: 'CAR vs DB')
    FactoryGirl.create(:score, quarter: 1)
    login
    visit 'games'
    click_link 'CAR at DB'
    user_should_be_able_to_view_but_not_submit_boxes
    user_should_not_be_able_to_pick_boxes
    user_should_be_able_to_view_box_numbers
    user_should_be_able_to_view_winners
    expect(current_path).to eq(game_path(locked_game.id))
  end

  private

  def blue_boxes(new_game)
    new_game.boxes.where(user_id: nil)
  end

  def count_user_boxes
    user_boxes.size
  end

  def green_boxes
    user_boxes
  end

  def red_boxes
    Box.where.not(user_id: nil) - user_boxes
  end

  def login
    visit 'signin'
    fill_in 'login', with: regular_user.name
    fill_in 'password', with: regular_user.password
    click_button 'SIGN IN'
  end

  def pick_random_boxes(new_game)
    3.times do
      box = new_game.boxes.where(user_id: nil).sample
      box.user_id = 2
      box.save
    end
  end

  def user_boxes
    Box.by_user(regular_user)
  end

  def user_should_be_able_to_pick(boxes)
    box = boxes.sample # takes random box in set
    click_button "#{box.home_team_coord}#{box.away_team_coord}"
    expect(page).to have_content 'Box saved!'
  end

  def user_should_be_able_to_view_and_submit_boxes
    within 'body' do
      expect(page).to have_css 'button'
      expect(page).to have_css 'form'
    end
  end

  def user_should_be_able_to_view_but_not_submit_boxes
    within 'body' do
      expect(page).to have_css 'button'
      expect(page).to_not have_css 'form'
    end
  end

  def user_should_be_able_to_view_box_letters
    within 'body' do
      Array('A'..'J').each do |num|
        expect(page).to have_css 'div h3', text: num
      end
    end
  end

  def user_should_be_able_to_view_box_numbers
    within 'body' do
      Array(0..9).each do |num|
        expect(page).to have_css 'div h3', text: num
      end
    end
  end

  def user_should_be_able_to_view_winners
    expect(page).to have_content 'Winning:'
  end

  def user_should_not_be_able_to_pick_boxes
    within 'body' do
      expect(page).to_not have_css 'form'
    end
  end

  def user_should_not_be_able_to_pick(boxes)
    box = boxes.sample # takes random box in set
    click_button "#{box.home_team_coord}#{box.away_team_coord}"
    expect(page).to have_content 'That box can\'t be picked'
  end
end
