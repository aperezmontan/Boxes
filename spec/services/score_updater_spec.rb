require 'rails_helper'

describe ScoreUpdater do
  describe "#update!" do
    let(:score) { FactoryGirl.create(:score, :quarter => 1, :game_info => "CAR vs DB") }

    context "updating scores" do
      it "updates scores that are relevant" do
        described_class.update!(score)
        expect(score.status == 0)
        updated_score = FactoryGirl.create(:score, :quarter => 4)
        described_class.update!(updated_score)
        expect(score.status == 1)
        expect(updated_score.status == 0)
      end

      it "does not update scores that are irrelevant" do
        described_class.update!(score)
        expect(score.status == 0)
        irrelevant_score = FactoryGirl.create(:score, :game_info => "CAR at DB", :quarter => 1)
        described_class.update!(irrelevant_score)
        expect(score.status == 0)
        expect(irrelevant_score.status == 0)
      end
    end
  end
end