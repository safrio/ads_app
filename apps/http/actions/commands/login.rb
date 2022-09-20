# frozen_string_literal: true

require 'json'
require 'hanami/action'

module HTTP
  module Actions
    module Commands
      class Login < Hanami::Action
        include Dry::Monads[:result]

        include Import[
          configuration: 'hanami.action.configuration',
          command: 'contexts.auth.commands.login'
        ]

        def handle(req, res)
          result = command.call(
            email: req.params[:email],
            password: req.params[:password]
          )

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
