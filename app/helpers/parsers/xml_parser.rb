module Parsers
  class XmlParser < BaseParser
    def run(disallowed_types = [])
      Hash.from_xml(data, disallowed_types)&.deep_symbolize_keys
    end
  end
end
