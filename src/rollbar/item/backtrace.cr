module Rollbar
  class Item
    class Backtrace
      property exception : Exception
      property message : String | Nil
      property frames : Array(Frame)

      def initialize(@exception, @message)
        @frames = generate_frames(@exception.inspect_with_backtrace)
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

      private def generate_frames(message)
        generated_frames = [] of Frame
        if raw_frames = message.scan(/\s([^\s\:]+):(\d+)([^\n]+)/)
          raw_frames.each_with_index do |frame, index|
            generated_frames << Frame.new(raw_frame: frame, index: index)
          end
        end

        generated_frames
      end
    end
  end
end
