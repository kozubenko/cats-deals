module ApiSources
  module CatsDeals
    class SourcesFactory
      %w[happy_cats unlimited_cats].each do |method|
        define_method(method) do
          "ApiSources::CatsDeals::#{method.camelize}".constantize.new
        end
      end
    end
  end
end
