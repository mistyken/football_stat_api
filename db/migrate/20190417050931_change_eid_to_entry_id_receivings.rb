class ChangeEidToEntryIdReceivings < ActiveRecord::Migration[5.2]
  def change
    rename_column :receivings, :eid, :entry_id
  end
end
