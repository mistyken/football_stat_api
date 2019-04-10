class AddUniqueToEidPassing < ActiveRecord::Migration[5.2]
  def change
    add_index :passings, :eid, unique: true
  end
end
