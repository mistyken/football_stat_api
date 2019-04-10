class AddUniqueToPidPlayer < ActiveRecord::Migration[5.2]
  def change
    add_index :players, :pid, unique: true
  end
end
