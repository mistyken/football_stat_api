class CreateRushings < ActiveRecord::Migration[5.2]
  def change
    create_table :rushings do |t|
      t.integer :yds
      t.integer :att
      t.integer :tds
      t.integer :fum
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
