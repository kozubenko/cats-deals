module Parsers
  class XmlParser < BaseParser
    def run
      Hash.from_xml(data)&.deep_symbolize_keys
    end
  end
end
