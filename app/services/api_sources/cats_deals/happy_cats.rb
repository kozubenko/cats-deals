require_relative '../base_source'

module ApiSources
  module CatsDeals
    class HappyCats < BaseSource
      def fetch_url
        ENV['HAPPY_CATS_API_URL']
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
            type: item[:title],
            price: item[:cost].to_i,
            location: item[:location],
            image: item[:img].to_s
          }
        end
      end
    end
  end
end
