module Auth
  module Commands
    class Signup
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)

      include Import[
        user_repo: 'contexts.auth.repositories.user'
      ]

      def call(payload)
        yield validate(payload)
        user = yield create_user(payload)

        Success(status: :ok, user: user.inspect)
      end

      private

      def validate(payload)
        if !payload[:name].to_s.empty? && !payload[:email].to_s.empty? && !payload[:password].to_s.empty?
          Success(true)
        else
          Failure([:invalid_payload, { error_message: 'Invalid payload', payload: payload }])
        end
      end

      def create_user(payload)
        params = nil
        Try[Dry::Struct::Error] do
          params = ::Auth::Entities::User.new(payload)
        end.to_result.or(
          Failure([:cant_create_user, { error_message: 'Can\'t create user', payload: payload }])
        )

        Try[SQLite3::ConstraintException] do
          user_repo.create(**params)
        end.to_result.or(
          Failure([:cant_create_user, { error_message: 'User already exist', payload: payload }])
        )
      end
    end
  end
end
