require "http/client"
require "json"

module Rollbar
  class Notifier
    property configuration : Configuration

    def initialize
      @configuration = Configuration.new
    end

    def log(level, *args)
    end

    def info
      report
    end

    def report(level : String, message : String | Nil, exception : Exception | Nil)
      item = build_item(level, message, exception)

      response = HTTP::Client.post(Configuration::DEFAULT_ENDPOINT, nil, item.to_json)

      puts response.body

      item["data"]
    end

    private def build_item(level : String, message : String | Nil, exception : Exception | Nil)
      item = Item.new(level, message, exception, self)

      item.build
    end
  end
end
