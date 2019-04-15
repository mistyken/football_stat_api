# spec/requests/players_spec.rb
require 'rails_helper'

RSpec.describe 'Players API', type: :request do
  # initialize test data
  let!(:players) {create_list(:Player, 10)}
  let(:player_id) {players.first.id}
  let(:player_pid) {players.first.pid}
  let(:player_name) {players.first.name}
  let(:player_position) {players.first.position}

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
    let!(:kicking) { create(:Kicking, player_id: player_id) }
    let!(:passing) { create(:Passing, player_id: player_id) }
    let!(:receiving) { create(:Receiving, player_id: player_id) }

    let(:player_id_2) {players.last.id}
    let(:player_pid_2) {players.last.pid}
    let(:player_name_2) {players.last.name}
    let!(:rushing_2) { create(:Rushing, player_id: player_id_2) }

    context 'when looking for a specific player by name' do
      before { get "/players?name=#{player_name}" }
      it 'returns the player rushing, kicking, passing, receiving stats' do
        expect(json.size).to eq(4)
        expect(json['rushing'].first['name']).to eq(player_name)
        expect(json['rushing'].first['player_id']).to eq(player_pid)
        expect(json['rushing'].first['position']).to eq(player_position)
        expect(json['rushing'].first['yds']).to eq(rushing['yds'])
        expect(json['rushing'].first['att']).to eq(rushing['att'])
        expect(json['rushing'].first['tds']).to eq(rushing['tds'])
        expect(json['rushing'].first['fum']).to eq(rushing['fum'])
        expect(json['rushing'].first['entry_id']).to eq(rushing['eid'])

        expect(json['receiving'].first['name']).to eq(player_name)
        expect(json['receiving'].first['player_id']).to eq(player_pid)
        expect(json['receiving'].first['position']).to eq(player_position)
        expect(json['receiving'].first['yds']).to eq(receiving['yds'])
        expect(json['receiving'].first['rec']).to eq(receiving['rec'])
        expect(json['receiving'].first['tds']).to eq(receiving['tds'])
        expect(json['receiving'].first['entry_id']).to eq(receiving['eid'])

        expect(json['kicking'].first['name']).to eq(player_name)
        expect(json['kicking'].first['player_id']).to eq(player_pid)
        expect(json['kicking'].first['position']).to eq(player_position)
        expect(json['kicking'].first['fld_goals_made']).to eq(kicking['fld_goals_made'])
        expect(json['kicking'].first['fld_goals_att']).to eq(kicking['fld_goals_att'])
        expect(json['kicking'].first['extra_pt_made']).to eq(kicking['extra_pt_made'])
        expect(json['kicking'].first['entry_id']).to eq(kicking['eid'])

        expect(json['passing'].first['name']).to eq(player_name)
        expect(json['passing'].first['player_id']).to eq(player_pid)
        expect(json['passing'].first['position']).to eq(player_position)
        expect(json['passing'].first['yds']).to eq(passing['yds'])
        expect(json['passing'].first['att']).to eq(passing['att'])
        expect(json['passing'].first['tds']).to eq(passing['tds'])
        expect(json['passing'].first['cmp']).to eq(passing['cmp'])
        expect(json['passing'].first['int']).to eq(passing['int'])
        expect(json['passing'].first['entry_id']).to eq(passing['eid'])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when looking for more than one player by name' do
      before { get "/players?name=#{player_name},#{player_name_2}"}
      it 'returns two players' do
        expect(json['rushing'].size).to eq(2)
      end

      it 'should return two correct user names' do
        expect(json['rushing'].last['name']).to eq(player_name_2)
        expect(json['rushing'].last['player_id']).to eq(player_pid_2)
        expect(json['rushing'].last['entry_id']).to eq(rushing_2['eid'])

        expect(json['rushing'].first['name']).to eq(player_name)
        expect(json['rushing'].first['player_id']).to eq(player_pid)
        expect(json['rushing'].first['entry_id']).to eq(rushing['eid'])
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
    let(:valid_attributes) {{name: 'Kenneth Chen', position: 'QA', pid: '1234'}}

    context 'when the request is valid' do
      before {post '/players', params: valid_attributes}

      it 'creates a player' do
        expect(json['name']).to eq('Kenneth Chen')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when player with same name but different pid is entered' do
      before {post '/players', params: valid_attributes}
      before {post '/players', params: {name: 'Kenneth Chen', position: 'QA', pid: '12345'}}
      before {get '/players'}

      it 'should create an additional player' do
        expect(json.size).to eq(12)
      end
    end

    context 'when player with same pid is entered again' do
      before {post '/players', params: valid_attributes}
      before {post '/players', params: {name: 'Jack Ma', position: 'QA', pid: '1234'}}
      before {get '/players'}

      it 'should not create an additional player' do
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
            .to match(/Validation failed: Position can't be blank, Pid can't be blank/)
      end
    end

    context 'when post to a new user with new passing stat' do
      let(:new_player_with_passing_stat) {{passing:[{name: 'Kenneth 1', position: 'QA', pid: 'ABCDEF',
                                           yds:12, att:12, tds:12, cmp:12, int:12, eid:'ABCDEF'}]}}

      before {post '/players', params: new_player_with_passing_stat}
      before {get "/players?name=#{new_player_with_passing_stat['name']}"}

      it 'should return the player with passing stat' do
        expect(json['passing'].first['name']).to eq(new_player_with_passing_stat['name'])
        expect(json['passing'].first['player_id']).to eq(new_player_with_passing_stat['pid'])
        expect(json['passing'].first['position']).to eq(new_player_with_passing_stat['position'])
        expect(json['passing'].first['yds']).to eq(new_player_with_passing_stat['yds'])
        expect(json['passing'].first['att']).to eq(new_player_with_passing_stat['att'])
        expect(json['passing'].first['tds']).to eq(new_player_with_passing_stat['tds'])
        expect(json['passing'].first['cmp']).to eq(new_player_with_passing_stat['cmp'])
        expect(json['passing'].first['int']).to eq(new_player_with_passing_stat['int'])
        expect(json['passing'].first['entry_id']).to eq(new_player_with_passing_stat['eid'])
      end
    end

    context 'when post to an existing player with new rushing stat' do
      let(:existing_player_with_rushing_stat) {{rushing:[valid_attributes.merge({yds:1, att:1, tds:1, fum:1, eid:'ABCDEF'})]}}

      before {post '/players', params: existing_player_with_rushing_stat}
      before {get "/players?name=#{existing_player_with_rushing_stat['name']}"}

      it 'should return the player with rushing stat' do
        expect(json['rushing'].first['name']).to eq(existing_player_with_rushing_stat['name'])
        expect(json['rushing'].first['player_id']).to eq(existing_player_with_rushing_stat['pid'])
        expect(json['rushing'].first['position']).to eq(existing_player_with_rushing_stat['position'])
        expect(json['rushing'].first['yds']).to eq(existing_player_with_rushing_stat['yds'])
        expect(json['rushing'].first['att']).to eq(existing_player_with_rushing_stat['att'])
        expect(json['rushing'].first['tds']).to eq(existing_player_with_rushing_stat['tds'])
        expect(json['rushing'].first['fum']).to eq(existing_player_with_rushing_stat['fum'])
        expect(json['rushing'].first['entry_id']).to eq(existing_player_with_rushing_stat['eid'])
      end
    end

    # context 'when post two players with two play stat at same time' do
    # end
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