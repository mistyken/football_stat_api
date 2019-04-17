# spec/requests/passing_spec.rb
require 'rails_helper'

RSpec.describe 'Passings API' do
  # Initialize the test data
  let!(:player) { create(:Player) }
  let!(:passing) { create_list(:Passing, 20, player_id: player.id) }
  let(:player_id) { player.id }
  let(:id) { passing.first.id }

  # Test suite for GET /players/:player_id/passings
  describe 'GET /players/:player_id/passings' do
    before { get "/players/#{player_id}/passings" }

    context 'when player exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all player passings' do
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

  # Test suite for GET /players/:player_id/passings/:id
  describe 'GET /players/:player_id/passings/:id' do
    before { get "/players/#{player_id}/passings/#{id}" }

    context 'when player passing exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the passing' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when player passing does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Passing/)
      end
    end
  end

  # Test suite for POST /players/:player_id/passings
  describe 'POST /players/:player_id/passings' do
    let(:valid_attributes) { { yds:12, att:12, tds:12, cmp:12, int:12, entry_id:'asdf' } }

    context 'when request attributes are valid' do
      before { post "/players/#{player_id}/passings", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/players/#{player_id}/passings", params: { yds:12, att:12, tds:12 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Cmp can't be blank, Int can't be blank/)
      end
    end

    context 'when an request with existing eid' do
      before { post "/players/#{player_id}/passings", params: valid_attributes }
      before { get "/players/#{player_id}/passings" }
      it 'should not create another entry' do
        expect(json.size).to eq(21)
      end
    end
  end

  # Test suite for PUT /players/:player_id/passings/:id
  describe 'PUT /players/:player_id/passings/:id' do
    let(:valid_attributes) { { int:15 } }

    before { put "/players/#{player_id}/passings/#{id}", params: valid_attributes }

    context 'when passing exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the passing' do
        updated_passing = Passing.find(id)
        expect(updated_passing.int).to eql("15")
      end
    end

    context 'when the passing does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Passing/)
      end
    end
  end

  # Test suite for DELETE /players/:id
  describe 'DELETE /players/:id' do
    before { delete "/players/#{player_id}/passings/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end