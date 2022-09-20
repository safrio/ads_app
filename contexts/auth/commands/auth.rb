module Auth
  module Commands
    class Auth
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)

      include Import[
        jwt_coder: 'contexts.auth.lib.jwt_coder',
        user_session_repo: 'contexts.auth.repositories.user_session'
      ]

      AUTH_TOKEN = %r{\ABearer (?<token>.+)\z}

      def call(payload)
        token = yield validate(payload)
        uuid = yield decode_token(token)
        yield check_session(uuid: uuid)

        Success(status: :ok)
      end

      private

      def validate(payload)
        result = payload[:token]&.match(AUTH_TOKEN)

        unless result[:token].empty?
          Success(result[:token])
        else
          Failure([:invalid_payload, { error_message: 'Invalid payload', payload: payload }])
        end
      end

      def decode_token(token)
        Try do
          jwt_coder.decode(token)
        end.to_result.or(
          Failure([:invalid_token, { error_message: 'Invalid token' }])
        )
      end

      def check_session(uuid:)
        Try[Dry::Struct::Error] do
          user_session_repo.find_by_uuid(uuid)
        end.to_result.or(
          Failure([:invalid_token, { error_message: 'Invalid token' }])
        )
      end
    end
  end
end
