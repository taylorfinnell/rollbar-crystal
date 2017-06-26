module Rollbar
  class Item
    class Frame
      property backtrace : Backtrace
      property frame     : String

      def initialize(@backtrace, @frame)
      end

      def to_h
        match = frame.match(/.* at (.*) (\d+):(\d+)/)

        return {} of String => String | Int64 if match.nil?

        {
          "filename" => match[1],
          "lineno"   => match[2].to_i,
          "colno"    => match[3].to_i
        }
      end
    end
  end
end
