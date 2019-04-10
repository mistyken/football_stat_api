class AddUniqueToEidRushing < ActiveRecord::Migration[5.2]
  def change
    add_index :rushings, :eid, unique: true
  end
end
