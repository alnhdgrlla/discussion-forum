module Mutations
  class CreateTopic < BaseMutation
    argument :title, String, required: true
    argument :content, String, required: true

    type Types::TopicType

    def resolve(title:, content:)
      c_user = context[:current_user]
      return GraphQL::ExecutionError.new("You have to log in to favorite") unless c_user.present?

      return GraphQL::ExecutionError.new("title can not be blank") if title = ""
      
      return GraphQL::ExecutionError.new("content can not be blank") if content = ""
        
      Topic.create!(
        title: title,
        content: content,
        user: context[:current_user]
      )
    end
  end
end