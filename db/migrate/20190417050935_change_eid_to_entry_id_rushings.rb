class ChangeEidToEntryIdRushings < ActiveRecord::Migration[5.2]
  def change
    rename_column :rushings, :eid, :entry_id
  end
end
