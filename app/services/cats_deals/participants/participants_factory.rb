require_relative "happy_cats"
require_relative "unlimited_cats"

module CatsDeals
  module Participants
    class ParticipantsFactory
      def happy_cats
        HappyCats.new
      end

      def unlimited_cats
        UnlimitedCats.new
      end
    end
  end
end
