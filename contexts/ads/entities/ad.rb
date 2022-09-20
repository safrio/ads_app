module Ads
  module Entities
    class Ad < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, Core::Types::Integer
      attribute :user_id, Core::Types::Integer

      attribute :title, Core::Types::String
      attribute :description, Core::Types::String
      attribute :city, Core::Types::String
      attribute :lat, Core::Types::Float
      attribute :lon, Core::Types::Float
    end
  end
end
