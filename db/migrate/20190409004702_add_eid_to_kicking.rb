class AddEidToKicking < ActiveRecord::Migration[5.2]
  def change
    add_column :kickings, :eid, :string
  end
end
