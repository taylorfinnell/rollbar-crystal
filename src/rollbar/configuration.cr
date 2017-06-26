module Rollbar
  class Configuration
    DEFAULT_ENDPOINT = "https://api.rollbar.com/api/1/item/"
    DEFAULT_WEB_BASE = "https://rollbar.com"

    property access_token : String | Nil
    property environment  : String | Nil
  end
end
