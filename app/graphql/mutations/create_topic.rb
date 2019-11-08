module Mutations
  class CreateTopic < BaseMutation
    argument :title, String, required: true
    argument :content, String, required: true

    type Types::TopicType

    def resolve(title:, content:)
      if context[:current_user] 
        return GraphQL::ExecutionError.new("title can not be blank") if title = ""
        return GraphQL::ExecutionError.new("content can not be blank") if content = ""
        Topic.create!(
          title: title,
          content: content,
          user: context[:current_user]
        )
      else
        return GraphQL::ExecutionError.new("You need to log in to post a topic")
      end
    end
  end
end