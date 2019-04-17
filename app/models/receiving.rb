class Receiving < ApplicationRecord
  belongs_to :player

  # validation
  validates_presence_of :yds, :rec, :tds, :entry_id
end
