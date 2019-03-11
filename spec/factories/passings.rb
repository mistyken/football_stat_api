# spec/factories/passings.rb
FactoryBot.define do
  factory :Passing do
    yds 30
    att 30
    tds 30
    cmp 30
    int 30
    player_id nil
  end
end