require 'rails_helper'

RSpec.describe Rushing, type: :model do
  # Association test
  # ensure an rushing record belongs to a single player record
  it { should belong_to(:player) }
  # Validation test
  # ensure column yds, att, tds, fum is present before saving
  it { should validate_presence_of(:yds) }
  it { should validate_presence_of(:att) }
  it { should validate_presence_of(:tds) }
  it { should validate_presence_of(:fum) }
end
