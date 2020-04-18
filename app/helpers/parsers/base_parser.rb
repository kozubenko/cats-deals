module Parsers
  class BaseParser
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def run(*args)
      raise NotImplementedError
    end
  end
end
