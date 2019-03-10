class CreatePassings < ActiveRecord::Migration[5.2]
  def change
    create_table :passings do |t|
      t.integer :yds
      t.integer :att
      t.integer :tds
      t.integer :cmp
      t.integer :int
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
