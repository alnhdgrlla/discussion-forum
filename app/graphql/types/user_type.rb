class Types::UserType < Types::BaseObject
  field :id, ID, null: false
  field :name, String, null: false
  field :email, String, null: false
  field :favorite, [Types::FavoriteType], null: true
  field :topic, [Types::TopicType], null: true
  field :reply, [Types::ReplyType], null: true
  field :followees, [Types::UserType], null: true
  field :followers, [Types::UserType], null: true
end