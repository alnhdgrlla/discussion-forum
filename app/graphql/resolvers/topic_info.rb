module Resolvers
  class TopicInfo < Resolvers::Base
    argument :topic_id, ID, required: true

    type Types::TopicType, null: false

    def resolve(topic_id:)
      topic = Topic.find_by(id:topic_id)
      return GraphQL::ExecutionError.new("This topic does not exist") unless topic
      topic
    end
  end
end