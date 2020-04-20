require_relative "../base_source"

module ApiSources
  module CatsDeals
    class HappyCats < BaseSource
      def fetch_url
        ENV["HAPPY_CATS_API_URL"]
      end

      def options
        {}
      end

      def handle_response(response)
        response = ResponseHandler.new(response, parser: Parsers::XmlParser).parse
        response.dig(:cats, :cat)
      end
    end
  end
end
