module Resolvers
  class AllTopics < Resolvers::Base

    type [Types::TopicType], null: false

    argument :user_id, ID, required: false
    argument :offset_attributes,Types::OffsetAttributes,required: true

    def resolve(user_id: nil, offset_attributes:)
      c_user = context[:current_user]
      offset_params = offset_attributes.to_h
      
      if user_id
        topic = Topic.where(user_id: user_id)
        topic.limit(offset_params[:limit]).offset(offset_params[:offset])
      else
        c_feed = c_user.feed
        c_feed.limit(offset_params[:limit]).offset(offset_params[:offset])
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

# module Resolvers
#   class AllTopics < Resolvers::Base

#     type [Types::TopicType], null: false

#     argument :offset_attributes,Types::OffsetAttributes,required: true

#     def resolve(offset_attributes:)
#       offset_params = offset_attributes.to_h
      
#       Topic.all.limit(offset_params[:limit]).offset(offset_params[:offset])
#     end
#   end
# end