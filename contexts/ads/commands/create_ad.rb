module Ads
  module Commands
    class CreateAd
      include Dry::Monads[:result]

      include Import[
        ad_repo: 'contexts.ads.repositories.ad',
      ]

      def call(payload)
        if valid?(payload)
          result = ad_repo.create(**payload[:ad])

          Success(status: :ok, result: result.to_h)
        else
          Failure(status: :error, message: 'invalid payload')
        end
      end

      private

      def valid?(payload)
        !payload[:ad].empty? &&
          !payload[:ad][:title].to_s.empty? &&
          !payload[:ad][:description].to_s.empty? &&
          !payload[:ad][:city].to_s.empty?
      end
    end
  end
end
