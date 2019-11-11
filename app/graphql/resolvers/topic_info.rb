module Resolvers
  class TopicInfo < Resolvers::Base
    argument :topic_id, ID, required: true

    type Types::TopicType, null: false

    def resolve(topic_id:)
      c_user = context[:current_user]
      topic = Topic.find_by(id:topic_id)
      poster = User.where(user_id: topic.user_id)
      
      if topic.nil?
        return GraphQL::ExecutionError.new("This topic does not exist")
      else
        if !c_user.followees.include?(poster)
          topic
        else
          return GraphQL::ExecutionError.new("You are not following this user")
        end
      end
    end
  end
end