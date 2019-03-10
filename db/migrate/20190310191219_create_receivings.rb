class CreateReceivings < ActiveRecord::Migration[5.2]
  def change
    create_table :receivings do |t|
      t.integer :yds
      t.integer :tds
      t.integer :rec
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
