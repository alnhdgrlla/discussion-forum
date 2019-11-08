module Mutations
  class DeleteTopic < BaseMutation
    argument :topic_id, ID, required: true

    type Types::TopicType

    def resolve(topic_id:)
      topic  = Topic.find_by(id: topic_id)
      return GraphQL::ExecutionError.new("This topic does not exist") if !topic.present?
      if topic.user_id == context[:current_user].id
        topic.destroy
      else
        return GraphQL::ExecutionError.new("Forbidden action")
      end
    end
  end
end