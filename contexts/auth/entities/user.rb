module Auth
  module Entities
    class User < Dry::Struct
      require 'bcrypt'

      include BCrypt

      transform_keys(&:to_sym)

      transform_types do |type|
        if type.name == :password
          type.constructor do |value|
            begin
              Password.new(value)
            rescue BCrypt::Errors::InvalidHash
              Password.create(value)
            end
          end
        else
          type
        end
      end

      attribute? :id, Core::Types::Integer

      attribute :name, Core::Types::String
      attribute :email, Core::Types::String
      attribute :password, Core::Types::String
    end
  end
end
