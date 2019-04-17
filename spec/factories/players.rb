# spec/factories/players.rb
FactoryBot.define do
  factory :Player do
    name { Faker::TvShows::StarTrek.character }
    position {Faker::TvShows::StarTrek.specie}
    player_id {Faker::String::random(10)}
  end
end