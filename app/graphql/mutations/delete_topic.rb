module Mutations
  class DeleteTopic < BaseMutation
    argument :topic_id, ID, required: true

    type Types::TopicType

    def resolve(topic_id:)
      topic  = Topic.find_by(id: topic_id)
      topic.destroy if topic.present?
      # return GraphQL::ExecutionError.new("This topic does not exist")
    end
  end
end