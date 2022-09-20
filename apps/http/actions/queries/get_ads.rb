# frozen_string_literal: true

require 'json'
require 'hanami/action'

module HTTP
  module Actions
    module Queries
      class GetAds < Hanami::Action
        include Dry::Monads[:result]

        include Import[
          query: 'contexts.ads.queries.get_ads'
        ]

        def handle(req, res)
          result = query.call(req.params)

          case result
          in Success
            res.status  = 200
            res.body    = result.value!.to_json
          in Failure[_, error_message]
            halt 422, error_message.to_json
          end
        end
      end
    end
  end
end
