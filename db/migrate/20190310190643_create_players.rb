class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :pid
      t.string :eid
      t.string :position
      t.string :name

      t.timestamps
    end
  end
end
