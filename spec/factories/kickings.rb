# spec/factories/kickings.rb
FactoryBot.define do
  factory :Kicking do
    fld_goals_made 30
    fld_goals_att 30
    extra_pt_made 30
    extra_pt_att 30
    player_id nil
  end
end