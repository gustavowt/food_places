# frozen_string_literal: true

class NearestFoodPlacesController < ApplicationController
  def index
    limit = params[:limit].to_i | 1
    result = NearestFoodPlacesService.search_first(
      params[:address],
      params[:fooditem],
      params[:facility_type],
      limit
    )

    if result
      render json: result.map(&:attributes)
    else
      render json: { empty: true }
    end
  end
end
