require 'rails_helper'

describe GamesController do
  before(:each) do
    allow_any_instance_of(GamesController).to receive(:require_login) {}
  end

  describe '#edit' do
    it 'is routable' do
      expect(get: 'games/edit').to route_to(
        controller: 'games',
        action: 'show',
        id: 'edit'
      )
    end
  end

  describe '#new' do
    it 'is routable' do
      expect(get: 'games/new').to route_to(
        controller: 'games',
        action: 'show',
        id: 'new'
      )
    end
  end

  describe '#index' do
    it 'is routable' do
      expect(get: 'games').to route_to(
        controller: 'games',
        action: 'index'
      )
    end
  end

  describe '#show' do
    it 'is routable' do
      expect(get: 'games/1').to route_to(
        controller: 'games',
        action: 'show',
        id: '1'
      )
    end
  end

  describe '#update' do
    it 'routes to put update' do
      expect(put: 'games/1').to route_to(
        controller: 'games',
        action: 'update',
        id: '1'
      )
    end
  end

  context 'it does not route to' do
    it 'post create' do
      expect(post: 'games').not_to be_routable
    end

    it 'delete destroy' do
      expect(delete: 'games/1').not_to be_routable
    end
  end
end
