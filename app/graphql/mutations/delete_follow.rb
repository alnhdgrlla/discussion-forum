module Mutations
  class DeleteFollow < BaseMutation

    argument :followee_id, ID, required: true

    field :follower, Types::UserType, null: true
    field :followee, Types::UserType, null: true

    def resolve(followee_id:)
      c_user = context[:current_user]
      return GraphQL::ExecutionError.new("You have to log in to favorite") unless c_user.present?
      
      followee = User.find_by(id: followee_id) 
      
      return GraphQL::ExecutionError.new("Forbidden action") unless c_user.following?(followee) 
      c_user.unfollow(followee)
        {
         follower: c_user,
         followee: followee
        }
    end
  end
end
