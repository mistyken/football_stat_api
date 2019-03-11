# spec/factories/receivings.rb
FactoryBot.define do
  factory :Receiving do
    yds 30
    tds 30
    rec 30
    player_id nil
  end
end