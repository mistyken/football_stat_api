require 'rails_helper'

RSpec.describe Kicking, type: :model do
  # Association test
  # ensure an kicking record belongs to a single player record
  it { should belong_to(:player) }
  # Validation test
  # ensure column fld_goals_made, fld_goals_att, extra_pt_made, extra_pt_att is present before saving
  it { should validate_presence_of(:fld_goals_made) }
  it { should validate_presence_of(:fld_goals_att) }
  it { should validate_presence_of(:extra_pt_made) }
  it { should validate_presence_of(:extra_pt_att) }
end
