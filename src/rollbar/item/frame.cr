require "json"

module Rollbar
  class Item
    class Frame
      JSON.mapping({
        filename: String,
        lineno: Int32,
        colno: Int32
      })

      def initialize(raw_frame, index)
        @filename = raw_frame[1].split('/').last
        @lineno = raw_frame[2].to_i
        @colno = 0
      end
    end
  end
end
