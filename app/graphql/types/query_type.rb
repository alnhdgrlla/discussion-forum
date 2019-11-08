module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    field :all_topics, resolver: Resolvers::AllTopics
    field :topic_info, resolver: Resolvers::TopicInfo
    field :user_info, resolver: Resolvers::UserInfo
    field :all_favorites, resolver: Resolvers::AllFavorites
    field :current_user, resolver: Resolvers::CurrentUser
  end
end
