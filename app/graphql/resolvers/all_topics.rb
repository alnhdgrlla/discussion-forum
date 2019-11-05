module Resolvers
  class AllTopics < Resolvers::Base

    type [Types::TopicType], null: false

    def resolve
      Topic.all
    end
  end
end