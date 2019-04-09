class RemoveEidFromPlayers < ActiveRecord::Migration[5.2]
  def change
    remove_column :players, :eid
  end
end
