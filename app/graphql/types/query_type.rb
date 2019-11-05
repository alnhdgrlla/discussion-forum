module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    field :all_topics, resolver: Resolvers::AllTopics
  end
end
