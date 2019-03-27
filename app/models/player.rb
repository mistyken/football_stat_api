class Player < ApplicationRecord
  # model association
  has_many :Rushing, dependent: :destroy
  has_many :Kicking, dependent: :destroy
  has_many :Receiving, dependent: :destroy
  has_many :Passing, dependent: :destroy

  # validations
  validates_presence_of :name, :position, :pid, :eid

  scope :by_player_name, -> (name) { where(name: name) if name.present? }
end
