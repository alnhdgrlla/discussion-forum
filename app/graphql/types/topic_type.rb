class Types::TopicType < Types::BaseObject
  field :id, ID, null: false
  field :title, String, null: false
  field :content, String, null: false
  field :replies, [Types::ReplyType], null: false
  field :user, Types::UserType, null: false
end