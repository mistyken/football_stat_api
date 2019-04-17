class ChangeEidToEntryIdKickings < ActiveRecord::Migration[5.2]
  def change
    rename_column :kickings, :eid, :entry_id
  end
end
