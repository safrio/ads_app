# frozen_string_literal: true

require 'bundler/setup'
require 'hanami/api'
require 'hanami/middleware/body_parser'
require 'hanami/action'

module HTTP
  class App < Hanami::API
    use Hanami::Middleware::BodyParser, :json

    root to: Container['http.actions.queries.get_ads']

    post '/ads', to: Container['http.actions.commands.create_ad']

    post '/signup', to: Container['http.actions.commands.signup']
    post '/login', to: Container['http.actions.commands.login']

    # transport
    post '/auth', to: Container['http.actions.commands.auth']
  end
end
