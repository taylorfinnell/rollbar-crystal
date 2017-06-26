module Rollbar
  class Item
    class Backtrace
      property exception : Exception
      property message   : String | Nil
      property frames    : Hash(String, String | Int64) | Nil

      def initialize(@exception, @message)
      end

      def map_frames
        exception.backtrace.map do |frame|
          Frame.new(self, frame).to_h
        end
      end

      def trace_data
        {
          "frames"    => map_frames,
          "exception" => {
            "class"   => exception.class.name,
            "message" => message
          }
        }
      end
    end
  end
end
