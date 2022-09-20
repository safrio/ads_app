module Auth
  module Lib
    class JwtCoder
      require 'jwt'

      include Import[
        settings: 'settings'
      ]

      def encode(payload)
        JWT.encode(payload, settings.secret)
      end

      def decode(token)
        JWT.decode(token, settings.secret).first
      end
    end
  end
end
