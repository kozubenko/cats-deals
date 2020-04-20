require_relative "happy_cats"
require_relative "unlimited_cats"

module ApiSources
  module CatsDeals
    class SourcesFactory
      def happy_cats
        HappyCats.new
      end

      def unlimited_cats
        UnlimitedCats.new
      end
    end
  end
end
