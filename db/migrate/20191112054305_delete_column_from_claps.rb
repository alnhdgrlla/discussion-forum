class DeleteColumnFromClaps < ActiveRecord::Migration[6.0]
  def change
    remove_column :claps, :count
  end
end
