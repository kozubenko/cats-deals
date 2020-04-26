# frozen_string_literal: true

class RequestsController < ApplicationController
  def new
    @filters = Analytics::CatsDeals::BestPrice::AVAILABLE_FILTERS
  end

  def create
    request_params = {
      filters: params.permit(%i[type location])
    }

    redirect_to cats_deals_path(params: request_params)
  end
end
