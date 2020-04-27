module Parsers
  class JsonParser < BaseParser
    def run
      JSON.parse(data, symbolize_names: true)
    end
  end
end
