require "./rollbar"

Rollbar.configure do |config|
  config.access_token = ENV["POST_SERVER_ITEM_ACCESS_TOKEN"]
  config.environment  = "development"
end

class MyBigFatEexception < Exception
end

begin
  raise MyBigFatEexception.new
rescue e : MyBigFatEexception
  result1 = Rollbar.error(MyBigFatEexception.new)

  puts result1
end

# result1 = Rollbar.error(MyBigFatEexception.new)

# result2 = Rollbar.info("Do we has success?")
