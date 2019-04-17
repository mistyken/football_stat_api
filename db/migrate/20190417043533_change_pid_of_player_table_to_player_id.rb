class ChangePidOfPlayerTableToPlayerId < ActiveRecord::Migration[5.2]
  def change
    rename_column :players, :pid, :player_id
  end
end
