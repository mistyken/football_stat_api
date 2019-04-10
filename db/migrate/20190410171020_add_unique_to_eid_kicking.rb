class AddUniqueToEidKicking < ActiveRecord::Migration[5.2]
  def change
    add_index :kickings, :eid, unique: true
  end
end
