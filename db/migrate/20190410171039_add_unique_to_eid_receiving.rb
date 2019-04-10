class AddUniqueToEidReceiving < ActiveRecord::Migration[5.2]
  def change
    add_index :receivings, :eid, unique: true
  end
end
