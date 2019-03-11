class ChangeAttrPassing < ActiveRecord::Migration[5.2]
  def up
    change_table :passings do |t|
      t.change :yds, :string
      t.change :att, :string
      t.change :tds, :string
      t.change :cmp, :string
      t.change :int, :string
    end
  end
  def down
    change_table :passings do |t|
      t.change :yds, :integer
      t.change :att, :integer
      t.change :tds, :integer
      t.change :cmp, :integer
      t.change :int, :integer
    end
  end
end
