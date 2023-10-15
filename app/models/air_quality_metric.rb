# frozen_string_literal: true

class AirQualityMetric < ApplicationRecord
  # Associations
  belongs_to :location

  # Validations
  validates :aqi, :co, :no, :no2, :o3, :so2, :pm2_5, :pm10, :nh3, :dt, :location_id, presence: { message: "can't be blank" }

  def assess_air_quality
    case aqi
    when 1
      'Good'
    when 2
      'Fair'
    when 3
      'Moderate'
    when 4
      'Poor'
    when 5
      'Very Poor'
    end
  end
end
