# frozen_string_literal: true
require 'rake'

class RefreshAirQualityMetric
  include Sidekiq::Worker

  def perform
    begin
      Rails.application.load_tasks
      # Load current air pollution data for all locations
      Rake::Task['air_quality_metrics:import_current_air_pollution'].execute
    rescue Exception => e
      # Get the logger for the current class or module
      logger = Rails.logger
      logger.error('Errors occurred during importing current air pollution data by background process:')
      logger.error(e.message)
    end
  end
end
