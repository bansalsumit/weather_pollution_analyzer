class UpdateDtDataTypeInAirQualityMetric < ActiveRecord::Migration[7.0]
  def change
    remove_column :air_quality_metrics, :dt, :float
    add_column :air_quality_metrics, :dt, :datetime
  end
end
