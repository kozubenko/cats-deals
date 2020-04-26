# frozen_string_literal: true

class CatsDealsController < ApplicationController
  def index
    cats_deals = RemoteServices::FetchCollections.new(::ApiSources::CatsDeals::SourcesFactory).run
    @analysed_cats_deals = Analytics::CatsDeals::BestPrice.new(cats_deals, params[:filters] || {}).run
  end
end
