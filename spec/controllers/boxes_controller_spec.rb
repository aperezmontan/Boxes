require 'rails_helper'

RSpec.describe BoxesController do
  let(:picked_box) { Box.create(:user_id => 1) }
  let(:unpicked_box) { Box.create }
  let(:same_user_id) { 1 }
  let(:different_user_id) { 2 }

  describe "#update" do
    before(:each) do
      allow_any_instance_of(BoxesController).to receive(:require_login) { }
    end

    it "routes put update" do
      expect(:put => "boxes/1").to route_to(
        :controller => "boxes",
        :action => "update",
        :id => "1"
      )
    end

    context "can update a box with the correct parameters" do
      let(:pick) { "Pick" }
      let(:unpick) { "UnPick" }

      it "makes the user nil if a box is unpicked by that user" do
        allow_message_expectations_on_nil
        allow(@current_user).to receive(:id).and_return(same_user_id)
        @request.headers["HTTP_REFERER"] = 'http://test.host/games/edit'

        put :update, { :id => picked_box, :box_type => unpick }
        picked_box.reload
        expect(picked_box.user_id).to eq(nil)
        expect(flash[:success]).to_not be(nil)
        expect(response).to redirect_to(:back)
        expect(response.status).to be(302)
      end

      it "gives the box to the user if that box hasn't been picked yet" do
        allow_message_expectations_on_nil
        allow(@current_user).to receive(:id).and_return(same_user_id)
        @request.headers["HTTP_REFERER"] = 'http://test.host/games/edit'

        put :update, { :id => unpicked_box, :box_type => pick }
        unpicked_box.reload
        expect(unpicked_box.user_id).to eq(1)
        expect(flash[:success]).to_not be(nil)
        expect(response).to redirect_to(:back)
        expect(response.status).to be(302)
      end
    end

    context "won't save the box if it is already picked by another user" do
      let(:locked) { "Locked" }

      it "won't let the user pick the box" do
        allow_message_expectations_on_nil
        allow(@current_user).to receive(:id).and_return(different_user_id)
        @request.headers["HTTP_REFERER"] = 'http://test.host/games/edit'

        put :update, { :id => picked_box, :box_type => locked }
        picked_box.reload
        expect(picked_box.user_id).to_not eq(different_user_id)
        expect(flash[:error]).to_not be(nil)
        expect(response).to redirect_to(:back)
        expect(response.status).to be(302)
      end
    end
  end

  context "it does not route to any other routes" do
    it "post create" do
      expect(:post => "boxes").not_to be_routable
    end

    it "delete destroy" do
      expect(:delete => "boxes/1").not_to be_routable
    end

    it "get edit" do
      expect(:get => "boxes/edit").not_to be_routable
    end

    it "get index" do
      expect(:get => "boxes").not_to be_routable
    end

    it "get new" do
      expect(:get => "boxes/new").not_to be_routable
    end

    it "get show" do
      expect(:get => "boxes/1").not_to be_routable
    end
  end
end
