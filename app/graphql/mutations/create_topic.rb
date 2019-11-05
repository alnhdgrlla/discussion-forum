module Mutations
  class CreateTopic < BaseMutation
    argument :title, String, required: true
    argument :content, String, required: true

    type Types::TopicType

    def resolve(title:nil , content:nil)
      Topic.create!(
        title: title,
        content: content,
        user: context[:current_user]
      )
    end
  end
end