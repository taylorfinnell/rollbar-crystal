require "./item/*"

module Rollbar
  class Item
    property level     : String | Nil
    property message   : String | Nil
    property exception : Exception | Nil
    property notifier  : Notifier
    property payload   : Hash(String, Hash(String, Hash(String, Array(Hash(String, Int32 | String) | Hash(String, Int64 | String)) | Hash(String, String | Nil)) | Hash(String, Hash(String, String)) | Int64 | String | Nil) | String | Nil)

    def initialize(@level, @message, @exception, @notifier)
      @payload = {} of String => Hash(String, Hash(String, Array(Hash(String, Int32 | String) | Hash(String, Int64 | String)) | Hash(String, String | Nil)) | Hash(String, Hash(String, String)) | Int64 | String | Nil) | String | Nil
    end

    def build
      data = build_data

      @payload = {
        "access_token" => notifier.configuration.access_token,
        "data"         => data
      }

      payload
    end

    private def build_data
      data = {
        "timestamp"   => Time.now.epoch,
        "environment" => notifier.configuration.environment,
        "level"       => level,
        "language"    => "crystal",
        "body"        => build_body(body_param)
      }

      data
    end

    private def body_param
      exception ? exception : message
    end

    private def build_body(exception : Exception)
      Backtrace.new(exception, message).trace_data
    end

    private def build_body(message : String | Nil)
      {
        "message" => {
          "body" => message || "Empty Message"
        }
      }
    end
  end
end
