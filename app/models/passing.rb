class Passing < ApplicationRecord
  belongs_to :player

  # validation
  validates_presence_of :yds, :att, :tds, :cmp, :int
end
