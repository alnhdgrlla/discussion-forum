class ChangeColumnToClaps < ActiveRecord::Migration[6.0]
  def change
    change_column :claps, :count, :integer, default: 0
  end
end
