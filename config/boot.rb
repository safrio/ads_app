require 'dotenv'
Dotenv.load('.env', ".env.#{ENV.fetch('PROJECT_ENV', :development)}")

require_relative '../system/container'
Container.finalize!
