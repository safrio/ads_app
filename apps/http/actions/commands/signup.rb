# frozen_string_literal: true

require 'json'
require 'hanami/action'

module HTTP
  module Actions
    module Commands
      class Signup < Hanami::Action
        include Dry::Monads[:result]

        include Import[
          configuration: 'hanami.action.configuration',
          command: 'contexts.auth.commands.signup'
        ]

        def handle(req, res)
          # binding.irb
          result = command.call(
            name: req.params[:name],
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
