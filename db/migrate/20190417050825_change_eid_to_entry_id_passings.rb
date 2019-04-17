class ChangeEidToEntryIdPassings < ActiveRecord::Migration[5.2]
  def change
    rename_column :passings, :eid, :entry_id
  end
end
