# spec/factories/rushings.rb
FactoryBot.define do
  factory :Rushing do
    yds rand(30)
    att rand(30)
    tds rand(30)
    fum rand(30)
    player_id nil
  end
end