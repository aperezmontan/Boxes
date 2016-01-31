require 'rails_helper'

describe Score do
  context "it should validate the presence of" do
    let(:new_score) { FactoryGirl.build(:score) }

    it "home_score" do
      new_score.home_score = nil
      expect(new_score.valid?).to be(false)
    end

    it "away_score" do
      new_score.away_score = nil
      expect(new_score.valid?).to be(false)
    end

    it "quarter" do
      new_score.quarter = nil
      expect(new_score.valid?).to be(false)
    end
  end

  context "default value of" do
    let(:new_score) { FactoryGirl.build(:score) }

    it "is_final is" do
      expect(new_score.is_final).to eq(false)
    end
  end
end