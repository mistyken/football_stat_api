# spec/factories/rushings.rb
FactoryBot.define do
  factory :Rushing do
    yds 30
    att 30
    tds 30
    fum 30
    player_id nil
  end
end