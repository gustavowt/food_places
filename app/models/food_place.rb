class FoodPlace < ApplicationRecord
  validates :geo_point, :status, :facility_type, presence: true

  scope :closest_location, lambda { |point, distance|
    where(
      'ST_DWithin(geo_point, :point, :distance)',
      { point: Geographic.mkt(point), distance: distance * 1000 }
    )
  }

  def spherical_point=(value)
    self.geo_point = Geographic.point(*value)
  end
end
