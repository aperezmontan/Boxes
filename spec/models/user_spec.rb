require 'rails_helper'

describe User do
  describe 'validations' do
    context 'it should validate the presence of' do
      let(:new_user) { FactoryGirl.build(:user) }

      it 'name' do
        new_user.name = nil
        expect(new_user.valid?).to be(false)
      end

      it 'email' do
        new_user.email = nil
        expect(new_user.valid?).to be(false)
      end

      it 'password' do
        new_user.password = nil
        expect(new_user.valid?).to be(false)
      end
    end

    context 'it should validate the uniqueness of' do
      let(:new_user) { FactoryGirl.build(:user) }
      let(:copy_user) { FactoryGirl.build(:user) }

      it 'name' do
        new_user.name = 'Ari'
        new_user.save
        copy_user.name = 'Ari'
        expect(copy_user.valid?).to be(false)
      end

      it 'email' do
        new_user.email = 'ari@me.com'
        new_user.save
        copy_user.email = 'ari@me.com'
        expect(copy_user.valid?).to be(false)
      end
    end

    context 'it should validate the format of' do
      let(:new_user) { FactoryGirl.build(:user) }

      it 'email' do
        new_user.email = 'ari@me.com'
        expect(new_user.valid?).to be(true)
        new_user.email = 'arime.com'
        expect(new_user.valid?).to be(false)
        new_user.email = 'ari@me'
        expect(new_user.valid?).to be(false)
        new_user.email = 'me.com'
        expect(new_user.valid?).to be(false)
      end
    end
  end
end
