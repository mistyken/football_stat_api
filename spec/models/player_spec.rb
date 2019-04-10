require 'rails_helper'

RSpec.describe Player, type: :model do
  # Association test
  # ensure player model has a 1:m relationship with the rushing, passing, kicking and receiving model
  it { should have_many(:Rushing).dependent(:destroy) }
  it { should have_many(:Passing).dependent(:destroy) }
  it { should have_many(:Kicking).dependent(:destroy) }
  it { should have_many(:Receiving).dependent(:destroy) }
  # Validation tests
  # ensure columns pid, name and position are present before saving
  it { should validate_presence_of(:pid) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:position) }
end