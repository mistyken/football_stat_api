class AddEidToReceiving < ActiveRecord::Migration[5.2]
  def change
    add_column :receivings, :eid, :string
  end
end
