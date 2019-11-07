class Types::RelationshipType < Types::BaseObject
  field :id, ID, null: false
  field :followee_id, ID, null: false
  field :follower_id, ID, null: false
end