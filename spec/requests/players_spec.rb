# spec/requests/players_spec.rb
require 'rails_helper'

RSpec.describe 'Players API', type: :request do
  # initialize test data
  let!(:players) {create_list(:Player, 10)}
  let(:player_id) {players.first.id}
  let(:player_name) {players.first.name}

  # Test suite for GET /players
  describe 'GET /players' do
    # make HTTP get request before each example
    before {get '/players'}

    context 'when trying to get all players' do
      it 'returns players' do
        # Note `json` is a custom helper to parse JSON responses
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /players?name=' do
    let!(:rushing) { create(:Rushing, player_id: player_id) }
    before { get "/players?name=#{player_name}" }

    context 'when looking for a specific player by name' do
      it 'returns the player' do
        expect(json.size).to eq(1)
        expect(json.first['name']).to eq(player_name)
        expect(json.first['Rushing'][0]['yds']).to eq(rushing['yds'])
        expect(json.first['Rushing'][0]['att']).to eq(rushing['att'])
        expect(json.first['Rushing'][0]['tds']).to eq(rushing['tds'])
        expect(json.first['Rushing'][0]['fum']).to eq(rushing['fum'])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for GET /players/:id
  describe 'GET /players/:id' do
    before {get "/players/#{player_id}"}

    context 'when the record exists' do
      it 'returns the player' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(player_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:player_id) {100}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Player/)
      end
    end
  end

  # Test suite for POST /players
  describe 'POST /players' do
    # valid payload
    let(:valid_attributes) {{name: 'Kenneth Chen', position: 'QA', pid: 'ABCDE', eid: 'EFGHI'}}

    context 'when the request is valid' do
      before {post '/players', params: valid_attributes}

      it 'creates a player' do
        expect(json['name']).to eq('Kenneth Chen')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when player with same name is entered again' do
      before {post '/players', params: valid_attributes}
      before {get '/players'}

      it 'it should not create an additional player' do
        expect(json.size).to eq(11)
      end
    end

    context 'when player with same pid is entered again' do
      before {post '/players', params: {name: 'Jack Ma', position: 'QA', pid: 'ABCDE', eid: 'ETF'}}
      before {get '/players'}

      it 'it should not create an additional player' do
        expect(json.size).to eq(11)
      end
    end

    context 'when player with same eid is entered again' do
      before {post '/players', params: {name: 'Jack Ma', position: 'QA', pid: 'ETF', eid: 'EFGHI'}}
      before {get '/players'}

      it 'it should not create an additional player' do
        expect(json.size).to eq(11)
      end
    end

    context 'when the request is invalid' do
      before {post '/players', params: {name: 'Michael Jackson'}}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Position can't be blank, Pid can't be blank, Eid can't be blank/)
      end
    end
  end

  # Test suite for PUT /players/:id
  describe 'PUT /players/:id' do
    let(:valid_attributes) {{name: 'Kenneth Chen'}}

    context 'when the record exists' do
      before {put "/players/#{player_id}", params: valid_attributes}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /players/:id
  describe 'DELETE /players/:id' do
    before {delete "/players/#{player_id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end