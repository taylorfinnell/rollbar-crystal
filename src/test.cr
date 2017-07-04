require "./rollbar"
require "dotenv"

# Load environment
Dotenv.load

Rollbar.configure do |config|
  config.access_token = ENV["ROLLBAR_SERVER_ACCESS_TOKEN"]
  config.environment = "development"
end

class MyBigFatEexception < Exception
end

class FoobarException < Exception
end

begin
  raise FoobarException.new("I am an error!")
rescue e : Exception
  result1 = Rollbar.error(e)

  puts result1
end

# result1 = Rollbar.error(MyBigFatEexception.new)

# result2 = Rollbar.info("Do we has success?")
