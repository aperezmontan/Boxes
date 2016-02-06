require 'rails_helper'

describe BoxesController do
  describe '#update' do
    before(:each) do
      allow_any_instance_of(BoxesController).to receive(:require_login) {}
    end

    it 'routes to put update' do
      expect(put: 'boxes/1').to route_to(
        controller: 'boxes',
        action: 'update',
        id: '1'
      )
    end

    context 'it does not route to any other routes' do
      it 'post create' do
        expect(post: 'boxes').not_to be_routable
      end

      it 'delete destroy' do
        expect(delete: 'boxes/1').not_to be_routable
      end

      it 'get edit' do
        expect(get: 'boxes/edit').not_to be_routable
      end

      it 'get index' do
        expect(get: 'boxes').not_to be_routable
      end

      it 'get new' do
        expect(get: 'boxes/new').not_to be_routable
      end

      it 'get show' do
        expect(get: 'boxes/1').not_to be_routable
      end
    end
  end
end
