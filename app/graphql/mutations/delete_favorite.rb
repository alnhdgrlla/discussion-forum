module Mutations
  class DeleteFavorite < BaseMutation
    argument :favorite_id, ID, required: true

    type Types::FavoriteType

    def resolve(favorite_id:)
      c_user = context[:current_user]
      return GraphQL::ExecutionError.new("You have to log in to favorite") unless c_user.present?

      favorite  = Favorite.find_by(id: favorite_id)
      return GraphQL::ExecutionError.new("Has not favorited yet") unless favorite.present?
      
      if favorite.user_id == context[:current_user].id
        favorite.destroy
      else
        return GraphQL::ExecutionError.new("Forbidden action")
      end
    end
  end
end