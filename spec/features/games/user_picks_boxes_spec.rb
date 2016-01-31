require 'rails_helper'

feature "user picks boxes" do
  let(:regular_user) { FactoryGirl.create(:user, :name => "Cal",
                                                 :email => "cal@me.com",
                                                 :password => "123") }

  let!(:new_game) { FactoryGirl.create(:game, :home_team => "NYG", :away_team => "NYJ") }
  let!(:locked_game) { FactoryGirl.create(:game, :home_team => "DB", :away_team => "CAR", :status => 1) }

  scenario "that are in an open game" do
    login
    visit "games"
    click_link "NYJ at NYG"
    box_count = count_user_boxes
    user_should_be_able_to_view_boxes
    user_should_be_able_to_view_box_letters
    user_should_be_able_to_pick(blue_boxes)
    expect(count_user_boxes).to eq(box_count + 1)
    box_count = count_user_boxes
    user_should_be_able_to_pick(green_boxes)
    expect(count_user_boxes).to eq(box_count - 1)
    user_should_not_be_able_to_pick(red_boxes)
    expect(count_user_boxes).to eq(box_count)
  end

  scenario "but can't pick boxes from games that are locked" do
    login
    visit "games"
    click_link "CAR at DB"
    user_should_be_able_to_view_boxes
    user_should_not_be_able_to_pick_boxes
    user_should_be_able_to_view_box_numbers
    user_should_be_able_to_view_winners
    expect(current_path).to eq(game_path(locked_game.id))
  end

  def blue_boxes
    new_game.boxes.where(:user_id => nil).pluck(:id)
  end

  def count_user_boxes
    regular_user.boxes.size
  end

  def green_boxes
    user_boxes_ids
  end

  def red_boxes
    new_game.boxes.where(:user_id => !nil).pluck(:id) - user_boxes_ids
  end

  def login
    visit "signin"
    fill_in 'login', :with => regular_user.name
    fill_in 'password', :with => regular_user.password
    click_button "Sign In"
  end

  def user_boxes_ids
    regular_user.boxes.pluck(:id)
  end

  def user_should_be_able_to_pick(boxes)
    click_button "#edit_box_#{boxes.sample}"
    expect(page).to have_content 'Box Saved'
  end

  def user_should_be_able_to_view_boxes
    within 'body' do
      expect(page).to have_css 'button', type: button
    end
  end

  def user_should_be_able_to_view_box_letters
    within 'body' do
      Array("A".."J").each do |num|
        expect(page).to have_css 'tr td h3', text: num
      end
    end
  end

  def user_should_be_able_to_view_box_numbers
    within 'body' do
      Array(0..9).each do |num|
        expect(page).to have_css 'tr td h3', text: num
      end
    end
  end

  def user_should_not_be_able_to_pick_boxes
    within 'body' do
      expect(page).to_not have_css 'button', type: submit
    end
  end

  def user_should_not_be_able_to_pick(boxes)
    click_button "#edit_box_#{boxes.sample}"
    expect(page).to have_content 'That box can\'t be picked'
  end
end
