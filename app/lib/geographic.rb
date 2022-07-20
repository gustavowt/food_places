# frozen_string_literal: true

module Geographic
  extend self

  SRID = 4326

  def spherical_factory
    @spherical_factory ||= ::RGeo::Geographic.spherical_factory(srid: SRID)
  end

  def point(long, lat)
    spherical_factory.point(long, lat)
  end

  def mkt(feature)
    "srid=#{SRID};#{feature}"
  end
end
