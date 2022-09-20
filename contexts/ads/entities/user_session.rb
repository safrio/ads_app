module Main
  module Entities
    class UserSession < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, Core::Types::Integer
      attribute :user_id, Core::Types::Integer
    end
  end
end
