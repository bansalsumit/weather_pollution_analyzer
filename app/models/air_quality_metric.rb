# frozen_string_literal: true

class AirQualityMetric < ApplicationRecord
  # Associations
  belongs_to :location

  # Validations
  validates :aqi, :co, :no, :no2, :o3, :so2, :pm2_5, :pm10, :nh3, :dt, :location_id, presence: { message: "can't be blank" }
end
