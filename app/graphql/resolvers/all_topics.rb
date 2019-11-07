module Resolvers
  class AllTopics < Resolvers::Base

    type [Types::TopicType], null: false

    argument :user_id, ID, required: false

    def resolve(user_id: nil)
      c_user = context[:current_user]
      if user_id
        Topic.where(user_id: user_id)
      else
        c_user.feed
      end
    end
  end
end

# module Resolvers
#   class AllTopics < Resolvers::Base

#     type [Types::TopicType], null: false

#     argument :user_id, ID, required: false

#     def resolve(user_id: nil)
#       c_user = context[:current_user]
#         Topic.where(user_id: user_id)
#     end
#   end
# end

