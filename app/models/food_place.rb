class FoodPlace < ApplicationRecord
  validates :geo_point, :status, :facility_type, presence: true

  scope :closest_location, lambda { |point, limit|
    select(%(
      *,
      geo_point <-> '#{Geographic.srid_point(point)}' as dist
      )).limit(limit)
  }

  def spherical_point=(value)
    self.geo_point = Geographic.point(*value)
  end
end
