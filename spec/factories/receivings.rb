# spec/factories/receivings.rb
FactoryBot.define do
  factory :Receiving do
    yds rand(30)
    tds rand(30)
    rec rand(30)
    player_id nil
  end
end