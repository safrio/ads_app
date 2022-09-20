module Auth
  module Commands
    class Login
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)

      include Import[
        jwt_coder: 'contexts.auth.lib.jwt_coder',
        user_repo: 'contexts.auth.repositories.user',
        user_session_repo: 'contexts.auth.repositories.user_session'
      ]

      def call(payload)
        yield validate(payload)
        user = yield find_user(email: payload[:email])
        yield authenticate(hash: user.password, password: payload[:password])
        session = yield create_session(user_id: user.id)
        token = yield generate_token(uuid: session.uuid)

        Success(status: :ok, meat: { token: token })
      end

      private

      def validate(payload)
        if !payload[:email].to_s.empty? && !payload[:password].to_s.empty?
          Success(true)
        else
          Failure([:invalid_payload, { error_message: 'Invalid payload', payload: payload }])
        end
      end

      def find_user(email:)
        Try[Dry::Struct::Error] do
          user_repo.find_by_email(email)
        end.to_result.or(
          Failure([:user_not_found, { error_message: 'User not found', email: email }])
        )
      end

      def authenticate(hash:, password:)
        if BCrypt::Password.new(hash) == password
          Success(true)
        else
          Failure([:wrong_credentials, { error_message: 'Wrong credentials' }])
        end
      end

      def create_session(user_id:)
        Try[Dry::Struct::Error] do
          user_session_repo.create(user_id: user_id)
        end.to_result.or(
          Failure([:cant_create_session, { error_message: 'Can\'t create session', user_id: user_id }])
        )
      end

      def generate_token(uuid:)
        Try do
          jwt_coder.encode(uuid)
        end.to_result.or(
          Failure([:cant_generate_token, { error_message: 'Can\'t generage token' }])
        )
      end
    end
  end
end
