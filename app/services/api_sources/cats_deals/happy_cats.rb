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
        parsed_response = ResponseHandler.new(response, Parsers::XmlParser).parse
        serialize(parsed_response.dig(:cats, :cat))
      end

      private

      def serialize(data)
        data.map do |item|
          {
            cat_type: item[:title],
            price: item[:cost].to_i,
            location: item[:location],
            image: item[:img]
          }
        end
      end
    end
  end
end
