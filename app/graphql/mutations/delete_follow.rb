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

# module Mutations
#   class DeleteFollow < BaseMutation

#     argument :followee_id, ID, required: true

#     field :follower, Types::UserType, null: true
#     field :followee, Types::UserType, null: true

#     def resolve(followee_id:)
#       follower = context[:current_user]
#       followee = User.find(followee_id) 

#       if !follower.followees.include?(followee)
#         return GraphQL::ExecutionError.new("cannot unfollow users that you dont follow ")
#       elsif follower.followees.include?(follower)
#         return GraphQL::ExecutionError.new("cannot unfollow yourself")
#       else
#         follower.active_relationships.find_by(followee_id: followee).destroy
#         {
#           follower: follower,
#           followee: followee
#         }
#       end
#     end
#   end
# end