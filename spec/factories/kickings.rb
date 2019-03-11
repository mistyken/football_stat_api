# spec/factories/kickings.rb
FactoryBot.define do
  factory :Kicking do
    fld_goals_made { Faker::Number.between(1, 100) }
    fld_goals_att { Faker::Number.between(1, 100) }
    extra_pt_made { Faker::Number.between(1, 100) }
    extra_pt_att { Faker::Number.between(1, 100) }
    player_id { Faker::Number.between(1, 10000) }
  end
end