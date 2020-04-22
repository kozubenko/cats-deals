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
        serialize(response.dig(:cats, :cat))
      end

      def serialize(data)
        data.map do |item|
          {
            name: item[:title],
            price: item[:cost],
            location: item[:location],
            image: item[:img]
          }
        end
      end
    end
  end
end
