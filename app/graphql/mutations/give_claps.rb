# module Mutations
#   class GiveClaps < BaseMutation

#     argument :topic_id, ID, required: true
#     argument :claps, Integer, required: true

#     type Types::ClapType

#     def resolve(topic_id:, claps:)
#       c_user = context[:current_user]
#       return GraphQL::ExecutionError.new("You have to log in to favorite") unless c_user.present?
      
#       topic = Topic.find_by(id: topic_id) 
#       return GraphQL::ExecutionError.new("No topic exists with the ID") unless topic 
      
#       if !c_user.active_relationships.find_by(followee_id: topic.user_id).present?
#         return GraphQL::ExecutionError.new("You are not following this user")
#       else
#         current_claps = Clap.find(topic.)


#         c_user.claps.update(count: count)
#       end
#     end
#   end
# end

module Mutations
  class GiveClaps < BaseMutation

    argument :topic_id, ID, required: true
    argument :claps, Integer, required: true

    type Types::ClapType

    def resolve(topic_id:, claps:)
      c_user = context[:current_user]
      return GraphQL::ExecutionError.new("You have to log in to favorite") unless c_user.present?
      
      topic = Topic.find_by(id: topic_id) 
      return GraphQL::ExecutionError.new("No topic exists with the ID") unless topic 
      
      clap = Clap.where(user_id: c_user.id, topic_id: topic.id).first
      # binding.pry
      if clap.nil?
        Clap.create(user_id: c_user.id, topic_id: topic.id, count: claps)
      else
        clap.update(count: clap.count + claps)
        clap
      end
    end
  end
end
