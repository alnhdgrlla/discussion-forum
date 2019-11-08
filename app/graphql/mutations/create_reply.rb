# module Mutations
#   class CreateReply < BaseMutation
#     argument :content, String, required: true
#     argument :topic_id, Integer, required: true

#     type Types::ReplyType

#     def resolve(content:, topic_id: )
#       topic = Topic.find(topic_id)
#       if topic && context[:current_user]
#         Reply.create!(
#           content: content,
#           user_id: context[:current_user].id,
#           topic_id: topic.id
#         )
#       else
#         return GraphQL::ExecutionError.new("the topic does not exist") 
#       end
#     end
#   end
# end

module Mutations
  class CreateReply < BaseMutation
    argument :content, String, required: true
    argument :topic_id, Integer, required: true

    type Types::ReplyType

    def resolve(content:, topic_id: )
      c_user = context[:current_user]
      return GraphQL::ExecutionError.new("You have to log in to favorite") unless c_user.present?

      topic = Topic.find_by(id: topic_id)
      return GraphQL::ExecutionError.new("the topic does not exist") if !topic
      
      Reply.create!(
        content: content,
        user_id: context[:current_user].id,
        topic_id: topic.id
      )
    end
  end
end