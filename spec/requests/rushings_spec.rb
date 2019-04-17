# spec/requests/rushing_spec.rb
require 'rails_helper'

RSpec.describe 'Rushings API' do
  # Initialize the test data
  let!(:player) { create(:Player) }
  let!(:rushing) { create_list(:Rushing, 20, player_id: player.id) }
  let(:player_id) { player.id }
  let(:id) { rushing.first.id }

  # Test suite for GET /players/:player_id/rushings
  describe 'GET /players/:player_id/rushings' do
    before { get "/players/#{player_id}/rushings" }

    context 'when player exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all player rushings' do
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

  # Test suite for GET /players/:player_id/rushings/:id
  describe 'GET /players/:player_id/rushings/:id' do
    before { get "/players/#{player_id}/rushings/#{id}" }

    context 'when player rushing exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the rushing' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when player rushing does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Rushing/)
      end
    end
  end

  # Test suite for POST /players/:player_id/rushings
  describe 'POST /players/:player_id/rushings' do
    let(:valid_attributes) { { yds:1, att:1, tds:1, fum:1, entry_id:'asdf' } }

    context 'when request attributes are valid' do
      before { post "/players/#{player_id}/rushings", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/players/#{player_id}/rushings", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Yds can't be blank, Att can't be blank, Fum can't be blank, Tds can't be blank/)
      end
    end

    context 'when an request with existing eid' do
      before { post "/players/#{player_id}/rushings", params: valid_attributes }
      before { get "/players/#{player_id}/rushings" }
      it 'should not create another entry' do
        expect(json.size).to eq(21)
      end
    end
  end

  # Test suite for PUT /players/:player_id/rushings/:id
  describe 'PUT /players/:player_id/rushings/:id' do
    let(:valid_attributes) { { yds:30, att:30, tds:30, fum:30 } }

    before { put "/players/#{player_id}/rushings/#{id}", params: valid_attributes }

    context 'when rushing exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the rushing' do
        updated_rushing = Rushing.find(id)
        expect(updated_rushing.yds).to eql("30")
      end
    end

    context 'when the rushing does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Rushing/)
      end
    end
  end

  # Test suite for DELETE /players/:id
  describe 'DELETE /players/:id' do
    before { delete "/players/#{player_id}/rushings/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end