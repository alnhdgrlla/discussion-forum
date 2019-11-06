module Resolvers
  class AllFavorites < Resolvers::Base
    argument :user_id, ID, required: true

    type [Types::FavoriteType], null: false

    def resolve(user_id:)
      if User.find(user_id)
        Favorite.where(user_id: user_id)
      else
        return GraphQL::ExecutionError.new("this user does not exist")
      end
    end
  end
end