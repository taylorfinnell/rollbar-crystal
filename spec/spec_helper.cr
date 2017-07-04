require "spec"
require "../src/rollbar-crystal"
require "./rollbar"

Rollbar.configure do |config|
  config.access_token = ENV["ROLLBAR_SERVER_ACCESS_TOKEN"]
  config.environment  = "test"
end
