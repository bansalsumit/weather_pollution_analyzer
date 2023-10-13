require 'rake'

class RefreshAirQualityMetric
  include Sidekiq::Worker

  def perform
    begin
      Rails.application.load_tasks
      Rake::Task['air_quality_metrics:import'].execute
    rescue Exception => e
    end
  end
end
