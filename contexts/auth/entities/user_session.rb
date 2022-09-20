module Auth
  module Entities
    class UserSession < Dry::Struct
      transform_keys(&:to_sym)

      transform_types do |type|
        if type.name == :uuid
          type.constructor do |value|
            value.empty? ? SecureRandom.uuid : value
          end
        else
          type
        end
      end

      attribute :user_id, Core::Types::Integer
      attribute :uuid, Core::Types::String
    end
  end
end
