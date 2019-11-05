module Resolvers
  class PatientInfo < Resolvers::Base
    argument :user_id, ID, required: true

    type Types::UserType, null: false

    def resolve(user_id:)
      user = User.find_by(id:user_id)
      return GraphQL::ExecutionError.new("This user does not exist") unless user
      user
    end
  end
end