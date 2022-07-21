# frozen_string_literal: true

class FoodPlace < ApplicationRecord
  validates :geo_point, :status, :facility_type, presence: true

  scope :closest_location, lambda { |point, limit|
    select(
      %(
        *,
        geo_point <-> '#{Geographic.srid_point(point)}' as dist
      )
    )
      .order('dist ASC')
      .limit(limit)
  }

  scope :with_fooditem, lambda { |text|
    where(%(fooditems ilike '%#{text}%'))
  }

  scope :by_facility_type, lambda { |type|
    where(facility_type: type)
  }

  def spherical_point=(value)
    self.geo_point = Geographic.point(*value)
  end
end
