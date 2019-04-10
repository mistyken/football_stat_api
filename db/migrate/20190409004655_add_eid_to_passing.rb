class AddEidToPassing < ActiveRecord::Migration[5.2]
  def change
    add_column :passings, :eid, :string
  end
end
