require_relative "../base_source"

module ApiSources
  module CatsDeals
    class UnlimitedCats < BaseSource
      def fetch_url
        ENV["UNLIMITED_CATS_API_URL"]
      end

      def options
        {}
      end

      def handle_response(response)
        serialize(ResponseHandler.new(response).parse)
      end

      def serialize(data)
        data
      end
    end
  end
end
