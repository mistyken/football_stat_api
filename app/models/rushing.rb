class Rushing < ApplicationRecord
  # model association
  belongs_to :player

  # validation
  validates_presence_of :yds, :att, :fum, :tds, :entry_id
end
