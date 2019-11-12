class AddColumnToClaps < ActiveRecord::Migration[6.0]
  def change
    add_column :claps, :count, :ingeger
  end
end
