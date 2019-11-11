module Mutations
  class DeleteFollow < BaseMutation

    argument :followee_id, ID, required: true

    field :follower, Types::UserType, null: true
    field :followee, Types::UserType, null: true

    def resolve(followee_id:)
      c_user = context[:current_user]
      return GraphQL::ExecutionError.new("You have to log in to favorite") unless c_user.present?
      
      followee = User.find_by(id: followee_id) 
      return GraphQL::ExecutionError.new("No user exists with the ID") unless followee 
      
      if !c_user.active_relationships.find_by(id: followee_id).present?
        return GraphQL::ExecutionError.new("You are not following this user")
      else
        c_user.active_relationships.find(followee_id).destroy 
          {
          follower: c_user,
          followee: followee
          }
      end
    end
  end
end
