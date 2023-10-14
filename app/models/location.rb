# frozen_string_literal: true

class Location < ApplicationRecord
  # Validations
  validates :name, :lat, :long, :state, presence: { message: "can't be blank" }
  validates :name, uniqueness: true

  # Associations
  has_many :air_quality_metrics, dependent: :restrict_with_error

  # Callbacks
  before_destroy :check_associated_models

  # Query: to find average average quality index per location for:
  # to get all location wise
  # to get for particular city
  def self.average_aqi_per_location(city=nil)
    query = Location.includes(:air_quality_metrics)
    query = query.where('name ilike ?', "%#{city}%") if city.present?
    query.group('locations.id').average('air_quality_metrics.aqi')
  end

  # Query: to find average average quality index per month per location for:
  # to get all location wise
  # to get for particular city
  # to get for particular start_date
  # to get for particular end_date
  def self.average_aqi_per_month_per_location(city: nil, start_date: nil, end_date: nil)
    query = Location.includes(:air_quality_metrics)
    query = query.where('name ilike ?', "%#{city}%") if city.present?
    query = query.where('air_quality_metrics.created_at >= ?', start_date ) if start_date.present?
    query = query.where('air_quality_metrics.created_at <= ?', end_date ) if end_date.present?
    query.group('locations.id', "DATE_TRUNC('month', air_quality_metrics.created_at)")
    .average('air_quality_metrics.aqi')
  end

  # Query: to find average average quality index per state for:
  # to get all location wise
  # to get for particular state
  def self.average_aqi_per_state(state=nil)
    query = Location.includes(:air_quality_metrics)
    query = query.where('state ilike ?', "%#{state}%") if state.present?
    query.group('locations.state').average('air_quality_metrics.aqi')
  end

  private

  def check_associated_models
    if associated_models.exists?
      errors.add(:base, 'Cannot delete because there are associated records.')
      throw(:abort)
    end
  end
end
