module Resolvers
  class AllFavorites < Resolvers::Base
    argument :user_id, ID, required: true
    argument :limit, Integer, required: false
    argument :offset, Integer, required: false

    type [Types::FavoriteType], null: false

    def resolve(user_id:, limit: 10, offset: 0 )
      c_user = context[:current_user]
      user = User.find_by(id: user_id)
      return GraphQL::ExecutionError.new("this user does not exist") if !user
      return GraphQL::ExecutionError.new("You are not following this user") if !c_user.followees.include?(user)
      Favorite.where(user_id: user_id).limit(limit).offset(offset)
    end
  end
end