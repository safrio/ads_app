module Ads
  module Queries
    class GetAds
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)

      include Import[
        ads_repo: 'contexts.ads.repositories.ad'
      ]

      def call
        ads = yield get_ads

        Success(ads: ads)
      end

      private

      def get_ads
        Try[Dry::Struct::Error] do
          ads_repo.all_order_desc
        end.to_result.or(
          Failure([:error_loading, { error_message: 'Error loading ads' }])
        )
      end
    end
  end
end
