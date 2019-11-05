module Types
  class MutationType < BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :signin_user, mutation: Mutations::SignInUser
    field :create_topic, mutation: Mutations::CreateTopic
    field :create_reply, mutation: Mutations::CreateReply
    field :delete_topic, mutation: Mutations::DeleteTopic
    field :delete_reply, mutation: Mutations::DeleteReply
  end
end
