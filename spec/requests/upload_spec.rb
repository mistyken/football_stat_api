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
      expect(json['rushing'].first['player_id']).to eq(input['rushing'].first['player_id'])
      expect(json['rushing'].first['position']).to eq(input['rushing'].first['position'])
      expect(json['rushing'].first['yds']).to eq(input['rushing'].first['yds'])
      expect(json['rushing'].first['att']).to eq(input['rushing'].first['att'])
      expect(json['rushing'].first['tds']).to eq(input['rushing'].first['tds'])
      expect(json['rushing'].first['fum']).to eq(input['rushing'].first['fum'])
      expect(json['rushing'].first['entry_id']).to eq(input['rushing'].first['entry_id'])
      expect(json['receiving'].size).to eq(1)
      expect(json['receiving'].first['name']).to eq(input['receiving'].last['name'])
      expect(json['receiving'].first['player_id']).to eq(input['receiving'].last['player_id'])
      expect(json['receiving'].first['position']).to eq(input['receiving'].last['position'])
      expect(json['receiving'].first['yds']).to eq(input['receiving'].last['yds'])
      expect(json['receiving'].first['tds']).to eq(input['receiving'].last['tds'])
      expect(json['receiving'].first['rec']).to eq(input['receiving'].last['rec'])
      expect(json['receiving'].first['entry_id']).to eq(input['receiving'].last['entry_id'])
    end
  end
end