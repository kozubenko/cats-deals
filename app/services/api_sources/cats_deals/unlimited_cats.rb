require_relative '../base_source'

module ApiSources
  module CatsDeals
    class UnlimitedCats < BaseSource
      def fetch_url
        ENV['UNLIMITED_CATS_API_URL']
      end

      def options
        {}
      end

      def handle_response(response)
        serialize(ResponseHandler.new(response, ::Parsers::JsonParser).parse)
      end

      private

      def serialize(data)
        data.map do |item|
          {
            cat_type: item[:name],
            price: item[:price].to_i,
            location: item[:location],
            image: item[:image]
          }
        end
      end
    end
  end
end
