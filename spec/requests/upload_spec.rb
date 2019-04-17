# spec/requests/upload_spec.rb
require 'rails_helper'

describe 'Upload API', type: :request do
  let!(:input) { JSON.parse(File.read('spec/requests/input.json')) }

  context 'When an input json is uploaded' do
    before {post '/upload', params: input}
    before {get "/players?name=#{input['rushing'].first['name']}" }  # This should be Ahmad Bradshaw
    it 'should accept input json and update player stats' do
      expect(json['rushing'].size).to eq(1)
      expect(json['rushing'].first['name']).to eq(input['rushing'].first['name'])
      expect(json['rushing'].first['player_id']).to eq(player_pid)
      expect(json['rushing'].first['position']).to eq(player_position)
      expect(json['rushing'].first['yds']).to eq(rushing['yds'])
      expect(json['rushing'].first['att']).to eq(rushing['att'])
      expect(json['rushing'].first['tds']).to eq(rushing['tds'])
      expect(json['rushing'].first['fum']).to eq(rushing['fum'])
      expect(json['rushing'].first['entry_id']).to eq(rushing['eid'])
    end
  end
end