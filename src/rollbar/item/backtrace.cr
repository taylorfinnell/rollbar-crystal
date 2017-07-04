module Rollbar
  class Item
    class Backtrace
      property exception : Exception
      property message : String | Nil
      property frames : Array(Hash(String, String | Int32))

      def initialize(@exception, @message)
        @frames = map_frames
      end

      def map_frames
        @exception.backtrace.map { |frame| Frame.new(frame).data }
      end

      def trace_data
        {
          "frames"    => frames,
          "exception" => {
            "class"   => exception.class.name,
            "message" => message,
          },
        }
      end
    end
  end
end
