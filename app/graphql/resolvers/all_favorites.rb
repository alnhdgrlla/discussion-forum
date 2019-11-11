module Resolvers
  class AllFavorites < Resolvers::Base
    argument :user_id, ID, required: true

    type [Types::FavoriteType], null: false

    def resolve(user_id:)
      user = User.find_by(id: user_id)
      return GraphQL::ExecutionError.new("this user does not exist") if !user
      Favorite.where(user_id: user_id) if user
    end
  end
end