class ChangeAttrReceivings < ActiveRecord::Migration[5.2]
  change_table :receivings do |t|
    t.change :yds, :string
    t.change :rec, :string
    t.change :tds, :string
  end
end
def down
  change_table :receivings do |t|
    t.change :yds, :integer
    t.change :rec, :integer
    t.change :tds, :integer
  end
end
