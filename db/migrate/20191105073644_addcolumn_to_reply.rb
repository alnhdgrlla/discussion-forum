class AddcolumnToReply < ActiveRecord::Migration[6.0]
  def change
    add_reference :replies, :user, foreign_key: true
  end
end
