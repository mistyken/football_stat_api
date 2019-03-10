# spec/factories/kickings.rb
FactoryBot.define do
  factory :Kicking do
    fld_goals_made rand(30)
    fld_goals_att rand(30)
    extra_pt_made rand(30)
    extra_pt_att rand(30)
    player_id nil
  end
end