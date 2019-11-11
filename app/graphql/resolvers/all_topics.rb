# module Resolvers
#   class AllTopics < Resolvers::Base

#     type [Types::TopicType], null: false

#     argument :user_id, ID, required: false
#     argument :limit, Integer, required: false
#     argument :offset, Integer, required: false

#     def resolve(user_id: nil, limit: 10, offset: 0 )
#       c_user = context[:current_user]
#       return GraphQL::ExecutionError.new("You have to log in to favorite") unless c_user.present?
#       binding.pry
#       if !user_id
#         c_feed = c_user.topics
#         c_feed.limit(limit).offset(offset)
#         byebug
#       else
#         followee = User.find(user_id)
#         if User.find_by(id: user_id).nil?
#           return GraphQL::ExecutionError.new("No user exists with that ID")
#         else
#           if c_user.followees.include?(followee)  
#             # topic = Topic.where(user_id: user_id).and(Topic.where(user_id: active_relationships.select(:followee_id)))
#             topic =Topic.where(user_id: [c_user.id, c_user.followees.select(:id)].flatten)
            
#             topic.limit(limit).offset(offset)
#           else
#             return GraphQL::ExecutionError.new("You are not following this user")
#           end
#         end
#       end
#     end
#   end
# end


# all
# return Tweet.where(user_id: [ cu.id, cu.following.select(:id)].flatten).where("content like ?", "%#{keyword}%")&.order(id: "desc").offset(pagination[0]).limit(pagination[1])

module Resolvers
  class AllTopics < Resolvers::Base

    type [Types::TopicType], null: false

    argument :user_id, ID, required: false
    argument :limit, Integer, required: false
    argument :offset, Integer, required: false

    def resolve(user_id: nil, limit: 10, offset: 0 )
      c_user = context[:current_user]
      return GraphQL::ExecutionError.new("You have to log in to favorite") unless c_user.present?
 
      if !user_id
        c_feed = Topic.where(user_id: [c_user.id, c_user.followees.select(:id)].flatten)
        c_feed.limit(limit).offset(offset)
      else
        followee = User.find(user_id)
        if User.find_by(id: user_id).nil?
          return GraphQL::ExecutionError.new("No user exists with that ID")
        else
          if c_user.followees.include?(followee)  
            # topic = Topic.where(user_id: user_id).and(Topic.where(user_id: active_relationships.select(:followee_id)))
            topic = Topic.where(user_id: followee.id)
            topic
          else
            return GraphQL::ExecutionError.new("You are not following this user")
          end
        end
      end
    end
  end
end
