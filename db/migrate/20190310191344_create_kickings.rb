class CreateKickings < ActiveRecord::Migration[5.2]
  def change
    create_table :kickings do |t|
      t.integer :fld_goals_made
      t.integer :fld_goals_att
      t.integer :extra_pt_made
      t.integer :extra_pt_att
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
