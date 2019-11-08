# module Mutations
#   class CreateFavorite < BaseMutation
#     argument :topic_id, ID, required: true

#     type Types::FavoriteType

#     def resolve(topic_id:)
#       topic = Topic.find_by(id: topic_id)
#       return GraphQL::ExecutionError.new("This topic does not exist") if !topic
      
#       favorite = Favorite.find_by(topic_id: topic_id)
#       return GraphQL::ExecutionError.new("Already favorited") if favorite.find_by(user_id: context[:current_user].id)
      
#       Favorite.create!(
#         topic: topic,
#         user: context[:current_user]
#       )
#     end
#   end
# end

module Mutations
  class CreateFavorite < BaseMutation
    argument :topic_id, ID, required: true

    type Types::FavoriteType

    def resolve(topic_id:)
      c_user = context[:current_user]
      return GraphQL::ExecutionError.new("You have to log in to favorite") unless c_user.present?

      topic = Topic.find_by(id: topic_id)
      return GraphQL::ExecutionError.new("This topic does not exist") if !topic
      
      favorite = Favorite.where(topic_id: topic_id)
      return GraphQL::ExecutionError.new("Already favorited") if favorite.find_by(user_id: c_user.id)
      
      Favorite.create!(
        topic: topic,
        user: context[:current_user]
      )
    end
  end
end