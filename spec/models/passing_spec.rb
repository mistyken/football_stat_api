require 'rails_helper'

RSpec.describe Passing, type: :model do
  # Association test
  # ensure an passing record belongs to a single player record
  it { should belong_to(:player) }
  # Validation test
  # ensure column yds, att, tds, fum is present before saving
  it { should validate_presence_of(:yds) }
  it { should validate_presence_of(:att) }
  it { should validate_presence_of(:tds) }
  it { should validate_presence_of(:cmp) }
  it { should validate_presence_of(:int) }
  it { should validate_presence_of(:eid) }
end
