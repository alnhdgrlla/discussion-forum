# module Mutations
#   class DeleteReply < BaseMutation
#     argument :reply_id, ID, required: true

#     type Types::ReplyType

#     def resolve(reply_id:)
#       reply  = Reply.find_by(id: reply_id)
#       reply.destroy if reply.present?
#       # return GraphQL::ExecutionError.new("This topic does not exist")
#     end
#   end
# end

module Mutations
  class DeleteReply < BaseMutation
    argument :reply_id, ID, required: true

    type Types::ReplyType

    def resolve(reply_id:)
      reply  = Reply.find_by(id: reply_id)
      return GraphQL::ExecutionError.new("This reply does not exist") unless reply.present?
      if reply.user_id == context[:current_user].id
        reply.destroy
      else
        return GraphQL::ExecutionError.new("Forbidden action")
      end
    end
  end
end