require "json"

module Rollbar
  class Item
    class Frame
      property frame : String

      def initialize(@frame)
      end

      def data
        match = frame.match(/.* at (.*) (\d+):(\d+)/)

        {
          "filename" => match ? match[1] : "",
          "lineno"   => match ? match[2].to_i : 0,
          "colno"    => match ? match[3].to_i : 0,
        }
      end
    end
  end
end
