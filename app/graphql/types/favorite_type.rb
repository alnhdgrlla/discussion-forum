class Types::FavoriteType < Types::BaseObject
  field :id, ID, null: false
  field :topic, Types::TopicType, null: false
  field :user, Types::UserType, null: false
end