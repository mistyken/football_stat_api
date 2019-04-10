class AddEidToRushing < ActiveRecord::Migration[5.2]
  def change
    add_column :rushings, :eid, :string
  end
end
