class Kicking < ApplicationRecord
  # model association
  belongs_to :player

  # validation
  validates_presence_of :fld_goals_made, :fld_goals_att, :extra_pt_made, :extra_pt_att, :entry_id
end
