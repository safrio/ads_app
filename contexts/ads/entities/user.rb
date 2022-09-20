module Main
  module Entities
    class User < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, Core::Types::Integer

      attribute :name, Core::Types::String
      attribute :email, Core::Types::String
      attribute :password, Core::Types::String
    end
  end
end
