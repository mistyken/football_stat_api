# spec/factories/passings.rb
FactoryBot.define do
  factory :Passing do
    yds rand(30)
    att rand(30)
    tds rand(30)
    cmp rand(30)
    int rand(30)
    player_id nil
  end
end