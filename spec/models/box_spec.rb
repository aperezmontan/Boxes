require 'rails_helper'

describe Box do
  context 'is_winner attribute' do
    it 'of true or false is valid' do
      expect(FactoryGirl.build(:box, is_winner: true).save).to eq(true)
      expect(FactoryGirl.build(:box, is_winner: false).save).to eq(true)
    end

    it 'will default to false otherwise' do
      new_box = FactoryGirl.build(:box)
      expect(new_box.save).to eq(true)
      expect(new_box.is_winner).to eq(false)
    end
  end

  describe '#update_box' do
    let(:current_user) { FactoryGirl.build(:user, id: 1) }
    let(:users_box) { FactoryGirl.build(:box, user_id: current_user.id) }
    let(:available_box) { FactoryGirl.build(:box) }
    let(:unavailable_box) { FactoryGirl.build(:box, user_id: 2) }

    before(:each) do
      allow_any_instance_of(User).to receive(:id).and_return(1)
    end

    context 'when box is available' do
      it 'allows user to pick an unpicked box' do
        expect(available_box.update_box(current_user)).to eq(true)
        expect(available_box.user_id).to eq(current_user.id)
      end

      it 'allows user to unpick their own box' do
        expect(users_box.update_box(current_user)).to eq(true)
        expect(users_box.user_id).to eq(nil)
      end
    end

    context 'when box is unavailable' do
      it 'does not allow user to pick an unavailable box' do
        expect(unavailable_box.update_box(current_user)).to eq(false)
        expect(unavailable_box.user_id).to eq(2)
      end
    end
  end
end
