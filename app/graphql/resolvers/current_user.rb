module Resolvers
  class CurrentUser < Resolvers::Base

    type Types::UserType, null: false

    def resolve
      user = context[:current_user]
      return GraphQL::ExecutionError.new("This user does not exist") unless user
      user
    end
  end
end