require "spec"
require "../src/rollbar-crystal"
require "./rollbar"

Rollbar.configure do |config|
  config.access_token = ENV["POST_SERVER_ITEM_ACCESS_TOKEN"]
  config.environment  = "test"
end
