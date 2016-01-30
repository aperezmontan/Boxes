require 'rails_helper'

describe Game do
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
      game.
      game.boxes.size == 100
    end


  end
end