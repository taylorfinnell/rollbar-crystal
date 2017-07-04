require "./item/*"

module Rollbar
  class Item
    property level : String | Nil
    property message : String | Nil
    property exception : Exception | Nil
    property notifier : Notifier

    def initialize(@level, @message, @exception, @notifier)
    end

    def build
      data = build_data

      payload = {
        "access_token" => notifier.configuration.access_token,
        "data"         => data,
      }

      payload
    end

    private def build_data
      body = build_body(body_param)

      data = {
        "timestamp"   => Time.now.epoch,
        "environment" => notifier.configuration.environment,
        "level"       => level,
        "language"    => "crystal",
        "body"        => body,
      }

      data
    end

    private def body_param
      exception ? exception : message
    end

    private def build_body(exception : Exception)
      trace = Backtrace.new(exception, message)

      {
        "trace" => trace.trace_data,
      }
    end

    private def build_body(message : String | Nil)
      body = message || "Empty Message"

      {
        "message" => {
          "body" => body,
        },
      }
    end
  end
end
