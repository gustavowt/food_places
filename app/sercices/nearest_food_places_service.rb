# frozen_string_literal: true

class NearestFoodPlacesService
  attr_reader :address, :fooditem, :facility_type, :results_size

  def self.search_first(*options)
    new(*options).search_first
  end

  def initialize(address, fooditem, facility_type, results_size)
    @address = address
    @fooditem = fooditem
    @facility_type = facility_type
    @results_size = results_size
  end

  def search_first
    return if geocode_result.blank?

    ::FoodPlace
      .closest_location(center_point, results_size)
      .with_fooditem(fooditem)
      .by_facility_type(facility_type)
      &.to_a
  end

  private

  def center_point
    [geocode_result['lon'], geocode_result['lat']].join ' '
  end

  def geocode_result
    @geocode_result = ::Geocoder.search(address)&.first&.data
  end
end
