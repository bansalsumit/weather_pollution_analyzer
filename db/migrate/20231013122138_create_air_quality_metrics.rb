class CreateAirQualityMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :air_quality_metrics do |t|
      t.float :aqi
      t.float :co
      t.float :no
      t.float :no2
      t.float :o3
      t.float :so2
      t.float :pm2_5
      t.float :pm10
      t.float :nh3
      t.float :dt
      t.references :location, index: true

      t.timestamps
    end
  end
end
