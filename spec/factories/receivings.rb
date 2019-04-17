# spec/factories/receivings.rb
FactoryBot.define do
  factory :Receiving do
    yds { Faker::Number.between(1, 100) }
    tds { Faker::Number.between(1, 100) }
    rec { Faker::Number.between(1, 100) }
    player_id { Faker::Number.between(1, 10000) }
    entry_id {Faker::String::random(10)}
  end
end