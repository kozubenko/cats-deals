module AnalyticsServices
  module CatsDeals
    class BestPrice
      attr_reader :deals

      def initialize(deals)
        @deals = deals
      end
    end
  end
end
