class ChangeAttrKickings < ActiveRecord::Migration[5.2]
  def up
    change_table :kickings do |t|
      t.change :fld_goals_made, :string
      t.change :fld_goals_att, :string
      t.change :extra_pt_made, :string
      t.change :extra_pt_att, :string
    end
  end
  def down
    change_table :kickings do |t|
      t.change :fld_goals_made, :integer
      t.change :fld_goals_att, :integer
      t.change :extra_pt_att, :integer
      t.change :extra_pt_made, :integer
    end
  end
end
