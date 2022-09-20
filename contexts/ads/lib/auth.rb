module Ads
  module Lib
    class Auth
      require 'rest-client'

      include Import[
        settings: 'settings'
      ]

      def call(payload)
        RestClient::Request.execute(method: :post,
                                    url: "#{settings.auth_service_url}/auth".freeze,
                                    headers: { 'Authorization': payload[:header] },
                                    payload: {},
                                    verify_ssl: OpenSSL::SSL::VERIFY_NONE)
      rescue RestClient::UnprocessableEntity
        false
      end
    end
  end
end
