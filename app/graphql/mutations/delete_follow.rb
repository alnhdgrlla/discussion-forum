module Mutations
  class DeleteFollow < BaseMutation

    argument :followee_id, ID, required: true

    field :follower, Types::UserType, null: true
    field :followee, Types::UserType, null: true
    field :error, String, null: false

    def resolve(followee_id:)
      follower = context[:current_user]
      followee = User.find(followee_id) 
      if follower.unfollow(followee)
        {
         follower: follower,
         followee: followee
        }
      else
        {
        error: GraphQL::ExecutionError.new("cannot unfollow the  same user twice")
        }
      end
    end
  end
end