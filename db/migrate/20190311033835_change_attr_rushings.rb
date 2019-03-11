class ChangeAttrRushings < ActiveRecord::Migration[5.2]
  def up
    change_table :rushings do |t|
      t.change :yds, :string
      t.change :att, :string
      t.change :tds, :string
      t.change :fum, :string
    end
  end
  def down
    change_table :rushings do |t|
      t.change :yds, :integer
      t.change :att, :integer
      t.change :tds, :integer
      t.change :fum, :integer
    end
  end
end
