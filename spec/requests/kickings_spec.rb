# spec/requests/kicking_spec.rb
require 'rails_helper'

RSpec.describe 'Kickings API' do
  # Initialize the test data
  let!(:player) { create(:Player) }
  let!(:kicking) { create_list(:Kicking, 20, player_id: player.id) }
  let(:player_id) { player.id }
  let(:id) { kicking.first.id }

  # Test suite for GET /players/:player_id/kickings
  describe 'GET /players/:player_id/kickings' do
    before { get "/players/#{player_id}/kickings" }

    context 'when player exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all player kickings' do
        expect(json.size).to eq(20)
      end
    end

    context 'when player does not exist' do
      let(:player_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Player/)
      end
    end
  end

  # Test suite for GET /players/:player_id/kickings/:id
  describe 'GET /players/:player_id/kickings/:id' do
    before { get "/players/#{player_id}/kickings/#{id}" }

    context 'when player kicking exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the kicking' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when player kicking does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Kicking/)
      end
    end
  end

  # Test suite for POST /players/:player_id/kickings
  describe 'POST /players/:player_id/kickings' do
    let(:valid_attributes) { { fld_goals_made:11, fld_goals_att:11, extra_pt_made:11, extra_pt_att:11, eid:'asdf'} }

    context 'when request attributes are valid' do
      before { post "/players/#{player_id}/kickings", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/players/#{player_id}/kickings", params: { fld_goals_att:11, extra_pt_made:11 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Fld goals made can't be blank, Extra pt att can't be blank/)
      end
    end
  end

  # Test suite for PUT /players/:player_id/kickings/:id
  describe 'PUT /players/:player_id/kickings/:id' do
    let(:valid_attributes) { { fld_goals_att:15 } }

    before { put "/players/#{player_id}/kickings/#{id}", params: valid_attributes }

    context 'when kicking exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the kicking' do
        updated_kicking = Kicking.find(id)
        expect(updated_kicking.fld_goals_att).to eql("15")
      end
    end

    context 'when the kicking does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Kicking/)
      end
    end
  end

  # Test suite for DELETE /players/:id
  describe 'DELETE /players/:id' do
    before { delete "/players/#{player_id}/kickings/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end