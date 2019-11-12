class Types::ClapType < Types::BaseObject
  field :id, ID, null: false
  field :count, Integer, null: false
  field :user, Types::UserType, null: false
  field :topic, Types::TopicType, null: false
end