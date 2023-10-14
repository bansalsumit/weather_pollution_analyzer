# frozen_string_literal: true

class Location < ApplicationRecord
  # Validations
  validates :name, :lat, :long, :state, presence: { message: "can't be blank" }
  validates :name, uniqueness: true

  # Associations
  has_many :air_quality_metrics, dependent: :restrict_with_error

  # Callbacks
  before_destroy :check_associated_models

  def self.average_aqi_per_location
    Location.includes(:air_quality_metrics).group('locations.id').average('air_quality_metrics.aqi')
  end

  def self.average_aqi_per_month_per_location
    Location.includes(:air_quality_metrics)
    .group('locations.id', "DATE_TRUNC('month', air_quality_metrics.created_at)")
    .average('air_quality_metrics.aqi')
  end

  def self.average_aqi_per_state
    Location.includes(:air_quality_metrics).group('locations.state').average('air_quality_metrics.aqi')
  end

  private

  def check_associated_models
    if associated_models.exists?
      errors.add(:base, 'Cannot delete because there are associated records.')
      throw(:abort)
    end
  end
end
