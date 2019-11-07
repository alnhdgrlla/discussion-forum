class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.references :followee
      t.references :follower

      t.timestamps
    end

    add_foreign_key :relationships, :users, column: :follower_id
    add_foreign_key :relationships, :users, column: :followee_id
  end
end
