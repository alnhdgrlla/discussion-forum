module Mutations
  class CreateReply < BaseMutation
    argument :content, String, required: true
    argument :topic_id, Integer, required: true

    type Types::ReplyType

    def resolve(content:, topic_id: )
      Reply.create!(
        content: content,
        user_id: context[:current_user].id,
        topic_id: Topic.find(topic_id).id
      )
    end
  end
end