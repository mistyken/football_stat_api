# spec/requests/receiving_spec.rb
require 'rails_helper'

RSpec.describe 'Receivings API' do
  # Initialize the test data
  let!(:player) { create(:Player) }
  let!(:receiving) { create_list(:Receiving, 20, player_id: player.id) }
  let(:player_id) { player.id }
  let(:id) { receiving.first.id }

  # Test suite for GET /players/:player_id/receivings
  describe 'GET /players/:player_id/receivings' do
    before { get "/players/#{player_id}/receivings" }

    context 'when player exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all player receivings' do
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

  # Test suite for GET /players/:player_id/receivings/:id
  describe 'GET /players/:player_id/receivings/:id' do
    before { get "/players/#{player_id}/receivings/#{id}" }

    context 'when player receiving exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the receiving' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when player receiving does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Receiving/)
      end
    end
  end

  # Test suite for POST /players/:player_id/receivings
  describe 'POST /players/:player_id/receivings' do
    let(:valid_attributes) { { yds:2, tds:2, rec:2, entry_id:'asdf' } }

    context 'when request attributes are valid' do
      before { post "/players/#{player_id}/receivings", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/players/#{player_id}/receivings", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Yds can't be blank, Rec can't be blank, Tds can't be blank/)
      end
    end

    context 'when an request with existing eid' do
      before { post "/players/#{player_id}/receivings", params: valid_attributes }
      before { get "/players/#{player_id}/receivings" }
      it 'should not create another entry' do
        expect(json.size).to eq(21)
      end
    end
  end

  # Test suite for PUT /players/:player_id/receivings/:id
  describe 'PUT /players/:player_id/receivings/:id' do
    let(:valid_attributes) { { yds:15, rec:15, tds:15 } }

    before { put "/players/#{player_id}/receivings/#{id}", params: valid_attributes }

    context 'when receiving exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the receiving' do
        updated_receiving = Receiving.find(id)
        expect(updated_receiving.rec).to eql("15")
      end
    end

    context 'when the receiving does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Receiving/)
      end
    end
  end

  # Test suite for DELETE /players/:id
  describe 'DELETE /players/:id' do
    before { delete "/players/#{player_id}/receivings/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end