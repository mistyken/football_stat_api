# spec/factories/passings.rb
FactoryBot.define do
  factory :Passing do
    yds { Faker::Number.between(1, 100) }
    att { Faker::Number.between(1, 100) }
    tds { Faker::Number.between(1, 100) }
    cmp { Faker::Number.between(1, 100) }
    int { Faker::Number.between(1, 100) }
    player_id { Faker::Number.between(1, 10000) }
    eid {Faker::String::random(10)}
  end
end