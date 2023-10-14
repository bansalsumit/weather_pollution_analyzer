# frozen_string_literal: true

class Location < ApplicationRecord
  has_many :air_quality_metrics

  def self.average_aqi_per_location
    Location.includes(:air_quality_metrics).group('locations.id').average('air_quality_metrics.aqi')
  end

  def self.average_aqi_per_month_per_location
    Location.includes(:air_quality_metrics)
    .group('locations.id', "DATE_TRUNC('month', air_quality_metrics.created_at)")
    .average('air_quality_metrics.aqi')
  end
end
