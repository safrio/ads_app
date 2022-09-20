require 'dry/system/provider_sources'

Container.register_provider(:settings, from: :dry_system) do
  before :prepare do
    require_relative '../../lib/core/types'
  end

  settings do
    setting :db_name, 'ads.db'
    setting :secret, '889ce91227342d21290f7246b621fec673949294650bd433253aa5cfbeb75fe413f1e6aa4a6c758df9c85996e4acef247af36bf909342f8958c46581285e7424'
    setting :auth_service_url, 'http://0.0.0.0:9292'
  end
end
