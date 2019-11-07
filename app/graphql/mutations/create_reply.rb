module Mutations
  class CreateReply < BaseMutation
    argument :content, String, required: true
    argument :topic_id, Integer, required: true

    type Types::ReplyType

    def resolve(content:, topic_id: )
      topic = Topic.find(topic_id)
      if topic
        Reply.create!(
          content: content,
          user_id: context[:current_user].id,
          topic_id: topic.id
        )
      else
        return GraphQL::ExecutionError.new("the topic does not exist") 
      end
    end
  end
end