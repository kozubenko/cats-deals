module Parsers
  class BaseParser
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def run(*_args)
      raise NotImplementedError
    end
  end
end
