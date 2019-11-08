module Mutations
  class CreateUser < BaseMutation
    # often we will need input types for specific mutation
    # in those cases we can define those input types in the mutation class itself
    class AuthProviderSignupData < Types::BaseInputObject
      argument :email, Types::AuthProviderEmailInput, required: false
    end

    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::UserType

    def resolve(name: nil, email: nil, password: nil)
      return GraphQL::ExecutionError.new("This name has already been taken") if User.find_by(name:name)
      return GraphQL::ExecutionError.new("This email has already been taken") if User.find_by(email:email)
      user =  User.create!(
        name: name,
        email: email,
        password: password
      )
      return GraphQL::ExecutionError.new("Creation did not finish successfuly") if !user
      user
    end
  end
end