require 'rails_helper'

feature "user creates a new score" do
  let(:new_game) { FactoryGirl.create(:game, :home_team => "NYG", :away_team => "NYJ", :description => "NYJ vs NYG") }
  let(:regular_user) { FactoryGirl.create(:user, :name => "Cal", :email => "cal@me.com", :password => "123") }

  scenario "that activates a game" do
    login
    expect(new_game.status).to eq("CREATED")
    user_should_be_able_to_view_link_to("Scores")
    click_link "Scores"
    expect(current_path).to eq(scores_path)
    user_should_be_able_to_view_link_to("Add New Score")
    click_link "Add New Score"
    fill_out_score_form(0, 0, 1, "NYJ vs NYG")
    expect(Game.first.status).to eq("ACTIVE")
  end


  scenario "that doesn't change the winner of the current quarter" do
    new_game = FactoryGirl.create(:game, :home_team => "NYG", :away_team => "NYJ", :description => "NYJ vs NYG")
    box_picker = FactoryGirl.create(:user, :name => "Cindy", :email => "cym@me.com", :password => "123")
    login
    click_link "Scores"
    click_link "Add New Score"
    fill_out_score_form(0, 0, 1, "NYJ vs NYG")
    pick_box(0, 0, new_game, box_picker)
    pick_box(0, 1, new_game, box_picker)
    click_link "Scores"
    click_link "Add New Score"
    fill_out_score_form(0, 0, 1, "NYJ vs NYG")
    click_link "NYJ at NYG"
    expect(page).to have_content 'Winning: Name: Cindy'
    click_link "Scores"
    click_link "Add New Score"
    fill_out_score_form(0, 11, 1, "NYJ vs NYG")
    click_link "NYJ at NYG"
    expect(page).to have_content 'Winning: Name: Cindy'
  end

  scenario "that changes the winner of the current quarter" do
    new_game = FactoryGirl.create(:game, :home_team => "NYG", :away_team => "NYJ", :description => "NYJ vs NYG")
    box_picker = FactoryGirl.create(:user, :name => "Cindy", :email => "cym@me.com", :password => "123", :id => 2)
    login
    click_link "Scores"
    click_link "Add New Score"
    fill_out_score_form(0, 0, 1, "NYJ vs NYG")
    pick_box(0, 0, new_game, box_picker)
    pick_box(0, 1, new_game, regular_user)
    click_link "Scores"
    click_link "Add New Score"
    fill_out_score_form(0, 0, 1, "NYJ vs NYG")
    click_link "NYJ at NYG"
    expect(page).to have_content 'Winning: Name: Cindy'
    click_link "Scores"
    click_link "Add New Score"
    fill_out_score_form(0, 11, 1, "NYJ vs NYG")
    click_link "NYJ at NYG"
    expect(page).to have_content 'Winning: Name: Cal'
  end

  scenario "that finalizes the previous quarter" do
    new_game = FactoryGirl.create(:game, :home_team => "NYG", :away_team => "NYJ", :description => "NYJ vs NYG")
    box_picker = FactoryGirl.create(:user, :name => "Cindy", :email => "cym@me.com", :password => "123", :id => 2)
    login
    click_link "Scores"
    click_link "Add New Score"
    fill_out_score_form(0, 0, 1, "NYJ vs NYG")
    pick_box(0, 0, new_game, box_picker)
    pick_box(0, 1, new_game, regular_user)
    click_link "Scores"
    click_link "Add New Score"
    fill_out_score_form(0, 11, 2, "NYJ vs NYG")
    click_link "NYJ at NYG"
    click_link "Scores"
    click_link "Add New Score"
    fill_out_score_form(22, 11, 3, "NYJ vs NYG")
    click_link "NYJ at NYG"
    expect(page).to have_content 'Winner: Name: Cindy'
    expect(page).to have_content 'Winner: Name: Cal'
  end

  private

  def login
    visit "signin"
    fill_in 'login', :with => regular_user.name
    fill_in 'password', :with => regular_user.password
    click_button "SIGN IN"
  end

  def fill_out_score_form(home_score, away_score, quarter, game_info)
    fill_in 'Home score', :with => home_score
    fill_in 'Away score', :with => away_score
    select quarter, :from => 'score_quarter'
    select game_info, :from => 'score_game_info'
    click_button "SUBMIT"
  end

  def pick_box(home_score, away_score, new_game, user)
    box = new_game.boxes.by_home_score_num(home_score).by_away_score_num(away_score).first
    box.user_id = user.id
    box.save
  end

  def user_should_be_able_to_view_link_to(title)
    within 'body' do
      expect(page).to have_css 'a', text: title
    end
  end

end