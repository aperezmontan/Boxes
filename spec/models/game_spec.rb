require 'rails_helper'

describe Game do
  context "default value of" do
    it "status is" do
      new_game = FactoryGirl.build(:game)
      expect(new_game.status).to eq("CREATED")
    end
  end

  context "home_team and away_team attributes" do
    it "without one is invalid" do
      expect(FactoryGirl.build(:game, :home_team => nil).save).to eq(false)
      expect(FactoryGirl.build(:game, :away_team => nil).save).to eq(false)
    end

    it "with both is valid" do
      new_game = FactoryGirl.build(:game)
      expect(new_game.save).to eq(true)
      expect(new_game.home_team).to_not eq(nil)
      expect(new_game.away_team).to_not eq(nil)
    end
  end

  describe "#constructor" do
    let(:game) { FactoryGirl.build(:game) }

    it "creates 100 boxes once" do
      game.boxes.size == 100
    end
  end

  describe '#populate_numbers' do
    let(:game) { FactoryGirl.build(:game) }

    it "not before its active" do
      unique_boxes = game.boxes.map { |box| [box.home_team_num, box.away_team_num] }
      expect(unique_boxes.size).to eq(100)
      expect(unique_boxes.uniq.size).to eq(1) #because no numbers have been assigned they're all nil
    end

    it "assigns a random home and away number between 0 and 9 to each box once status is ACTIVE" do
      game.save #must save to save boxes
      game.status = "ACTIVE"
      game.save
      unique_boxes = []
      unique_boxes = game.boxes.map { |box| [box.home_team_num, box.away_team_num] }
      expect(unique_boxes.uniq.size).to eq(unique_boxes.size)
    end
  end
end