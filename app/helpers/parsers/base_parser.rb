module Parsers
  class BaseParser
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def run
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
end
