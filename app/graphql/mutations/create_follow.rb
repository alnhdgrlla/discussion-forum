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
      # binding.pry
     if follower.followees.include?(followee) || follower.id == followee.id 
      return GraphQL::ExecutionError.new("Forbidden action") 
     else  
      follower.active_relationships.create!(followee_id: followee_id)
        {
          follower: follower,
          followee: followee
        }
      end
    end
  end
end