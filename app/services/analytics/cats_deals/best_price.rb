module Analytics
  module CatsDeals
    class BestPrice
      AVAILABLE_FILTERS = {
        types: %w[bengal abyssin persian],
        locations: %w[kiev odessa lviv]
      }.freeze

      attr_reader :collection, :params

      def initialize(collection, params = {})
        @collection = collection
        @params = params
      end

      def run
        filtered_collection = filter_collection(collection)
        sort_by_price(filtered_collection)
      end

      private

      def filter_collection(collection)
        collection.select do |item|
          [
            compare_strings(item[:type], params[:type]),
            compare_strings(item[:location], params[:location])
          ].all?
        end
      end

      def compare_strings(first, second)
        return false unless [first, second].all?

        first.downcase == second.downcase
      end

      def sort_by_price(collection)
        collection.sort_by { |obj| obj[:price] }
      end
    end
  end
end
