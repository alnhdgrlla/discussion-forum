module Mutations
  class CreateFollow < BaseMutation

    argument :followee_id, ID, required: true

    field :follower, Types::UserType, null: true
    field :followee, Types::UserType, null: true

    def resolve(followee_id:)
      c_user = context[:current_user]
      return GraphQL::ExecutionError.new("You have to log in to favorite") unless c_user.present?

      follower = context[:current_user]
      followee = User.find(followee_id) 
      
      return GraphQL::ExecutionError.new("Forbidden action") if follower.following?(followee) || follower.id == followee.id 
        follower.follow(followee)
        {
          follower: follower,
          followee: followee
        }
    end
  end
end