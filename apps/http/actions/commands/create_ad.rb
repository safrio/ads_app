# frozen_string_literal: true

require 'json'
require 'hanami/action'

module HTTP
  module Actions
    module Commands
      class CreateAd < Hanami::Action
        include Dry::Monads[:result]

        include Import[
          configuration: 'hanami.action.configuration',
          command: 'contexts.ads.commands.create_ad',
          auth_command: 'contexts.ads.lib.auth'
        ]

        def handle(req, res)
          return halt 401 unless auth_command.call(header: req.env['HTTP_AUTHORIZATION'])

          result = command.call(req.params)

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
