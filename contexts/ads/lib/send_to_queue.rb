module Ads
  module Lib
    class SendToQueue
      include Dry::Monads[:result]


      def call(payload)
        # ...

        Success(success: true)
      end
    end
  end
end
